-- Start an Octo PR review inside an isolated git worktree so it doesn't
-- disturb your working tree.
--   :PRReview <n|url>  open the Octo review surface in a worktree tab
--   :PRDiff  <n|url>   open the PR's changes in diffview (LSP-attached)
--   :PRDiff            diff the current tab's worktree
--   :PRReviewDone [n]  tear the worktree down
-- Slow git/gh calls run async (vim.system) so nvim stays responsive and each
-- step reports progress.

local M = {}

local WORKTREE_ROOT = vim.fn.expand("~/.cache/nvim/pr-worktrees")

-- pr_number -> { path, tab } for teardown
M.active = {}

-- Run argv (list form, no shell) synchronously; returns trimmed stdout + code.
-- Used only for fast, blocking-is-fine calls (repo_root, teardown).
local function sh(argv)
  local out = vim.fn.system(argv)
  return vim.trim(out), vim.v.shell_error
end

-- Run argv async in `cwd`; cb(result) fires on the main loop.
local function sh_async(argv, cwd, cb)
  vim.system(argv, { text = true, cwd = cwd }, function(res)
    vim.schedule(function()
      cb(res)
    end)
  end)
end

-- Progress toast. Reusing one id makes each step replace the previous, so the
-- steps read as a single updating notification rather than a stack.
local function step(cmd, msg)
  vim.notify(msg, vim.log.levels.INFO, { title = cmd, id = "pr_review" })
end

local function fail(cmd, msg)
  vim.notify(msg, vim.log.levels.ERROR, { title = cmd, id = "pr_review" })
end

local function repo_root()
  local root, code = sh({ "git", "rev-parse", "--show-toplevel" })
  if code ~= 0 or root == "" then
    return nil
  end
  return root
end

local function worktree_path(root, pr)
  local repo = vim.fn.fnamemodify(root, ":t")
  return string.format("%s/%s/%d", WORKTREE_ROOT, repo, pr)
end

-- Accept a bare PR number or a GitHub PR URL (with optional /files, #anchor).
local function parse_pr(arg)
  arg = tostring(arg or "")
  local n = arg:match("/pull/(%d+)") or arg:match("^%s*(%d+)%s*$")
  return n and tonumber(n) or nil
end

-- Ensure a worktree for #pr checked out on its head branch. cb(path|nil).
local function ensure_worktree(cmd, root, pr, sha, branch, cb)
  local path = worktree_path(root, pr)
  if vim.fn.isdirectory(path) == 1 then
    cb(path)
    return
  end

  step(cmd, "Fetching PR head…")
  sh_async({ "git", "fetch", "origin", string.format("pull/%d/head", pr) }, root, function(res)
    if res.code ~= 0 then
      fail(cmd, "failed to fetch PR #" .. pr .. ": " .. vim.trim(res.stderr or ""))
      cb(nil)
      return
    end

    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")

    step(cmd, "Creating worktree…")
    -- Check out on the PR's head branch (not detached): Octo's use_local_fs
    -- resolves the PR by matching the worktree's current branch to headRefName.
    sh_async({ "git", "worktree", "add", "-B", branch, path, sha }, root, function(add)
      if add.code ~= 0 then
        fail(cmd, "failed to create worktree: " .. vim.trim(add.stderr or ""))
        cb(nil)
        return
      end
      cb(path)
    end)
  end)
end

-- Resolve PR #pr, ensure its worktree, focus a tab tcd'd into it. cb(path|nil).
-- Reuses an existing tab for the same PR.
local function open_worktree_tab(cmd, pr, cb)
  local existing = M.active[pr]
  if existing and existing.tab and vim.api.nvim_tabpage_is_valid(existing.tab) then
    vim.api.nvim_set_current_tabpage(existing.tab)
    cb(existing.path)
    return
  end

  local root = repo_root()
  if not root then
    fail(cmd, "not inside a git repository")
    cb(nil)
    return
  end

  step(cmd, "Resolving PR #" .. pr .. "…")
  sh_async(
    { "gh", "pr", "view", tostring(pr), "--json", "headRefOid,headRefName", "-q", '.headRefOid + "\t" + .headRefName' },
    root,
    function(res)
      local info = vim.trim(res.stdout or "")
      if res.code ~= 0 or info == "" then
        fail(cmd, "could not resolve PR #" .. pr .. ": " .. vim.trim(res.stderr or ""))
        cb(nil)
        return
      end
      local sha, branch = info:match("^(%S+)\t(.+)$")
      if not sha then
        fail(cmd, "unexpected gh output: " .. info)
        cb(nil)
        return
      end

      ensure_worktree(cmd, root, pr, sha, branch, function(path)
        if not path then
          cb(nil)
          return
        end
        vim.cmd("tabnew")
        vim.cmd("tcd " .. vim.fn.fnameescape(path))
        M.active[pr] = { path = path, tab = vim.api.nvim_get_current_tabpage() }
        cb(path)
      end)
    end
  )
end

-- Refresh master, then open the current tab's worktree changes in diffview.
-- --imply-local keeps the local side a real file buffer so LSP attaches.
local function open_diffview(cmd)
  step(cmd, "Refreshing master…")
  sh_async({ "git", "fetch", "origin", "master" }, vim.fn.getcwd(), function(res)
    if res.code ~= 0 then
      vim.notify(cmd .. ": failed to refresh origin/master: " .. vim.trim(res.stderr or ""), vim.log.levels.WARN, { title = cmd, id = "pr_review" })
    end
    step(cmd, "Opening diffview…")
    require("diffview").open({ "origin/master...HEAD", "--imply-local" })
  end)
end

function M.review(pr)
  pr = parse_pr(pr)
  if not pr then
    fail("PRReview", "expected a PR number or URL")
    return
  end
  open_worktree_tab("PRReview", pr, function(path)
    if not path then
      return
    end
    step("PRReview", "Opening Octo review…")
    vim.cmd("Octo pr edit " .. pr)
    -- Octo needs the PR buffer loaded before a review can start.
    vim.defer_fn(function()
      vim.cmd("Octo review start")
    end, 500)
  end)
end

function M.diff(arg)
  -- With a PR number/URL, set up (or reuse) its worktree tab first; with no
  -- arg, diff whatever worktree the current tab is already in.
  if not arg then
    open_diffview("PRDiff")
    return
  end

  local pr = parse_pr(arg)
  if not pr then
    fail("PRDiff", "could not parse PR number from: " .. tostring(arg))
    return
  end
  open_worktree_tab("PRDiff", pr, function(path)
    if not path then
      return
    end
    open_diffview("PRDiff")
  end)
end

function M.done(pr)
  pr = tonumber(pr)
  local entry = pr and M.active[pr]
  if not entry then
    vim.notify("PRReviewDone: no active review" .. (pr and (" for #" .. pr) or ""), vim.log.levels.WARN)
    return
  end

  if entry.tab and vim.api.nvim_tabpage_is_valid(entry.tab) then
    vim.cmd("tabclose! " .. vim.api.nvim_tabpage_get_number(entry.tab))
  end

  local _, code = sh({ "git", "worktree", "remove", "--force", entry.path })
  if code ~= 0 then
    vim.notify("PRReviewDone: failed to remove worktree " .. entry.path, vim.log.levels.ERROR)
    return
  end

  M.active[pr] = nil
  vim.notify("PRReviewDone: cleaned up review #" .. pr, vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("PRReview", function(opts)
  M.review(opts.args)
end, { nargs = 1, desc = "Start an Octo PR review in an isolated worktree" })

vim.api.nvim_create_user_command("PRReviewDone", function(opts)
  M.done(opts.args ~= "" and opts.args or next(M.active))
end, { nargs = "?", desc = "Tear down a PR review worktree" })

vim.api.nvim_create_user_command("PRDiff", function(opts)
  M.diff(opts.args ~= "" and opts.args or nil)
end, { nargs = "?", desc = "Open a PR's changes in diffview (worktree-isolated, LSP-attached)" })

return M
