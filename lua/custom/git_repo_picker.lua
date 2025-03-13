local snacks = require("snacks.picker")

-- Function to find git repositories using lolcate
local function find_git_repos()
  local handle = io.popen("lolcate -b '\\.git$'")
  if not handle then
    return {}
  end
  local result = handle:read("*a")
  handle:close()

  local repos = {}
  for repo in result:gmatch("[^\r\n]+") do
    local cleaned_repo = repo:gsub("/%.git$", "")
    table.insert(repos, { text = cleaned_repo })
  end

  return repos
end

-- Main function to find and select a git repository
local function select_git_repo()
  local repos = find_git_repos()
  snacks.pick({
    title = "Select git repository",
    items = repos,
    transform = function(item)
      item.file = item.text
    end,
    sort = {
      fields = { "score:desc", "#text" },
    },
    confirm = function(picker, item)
      if not item then
        return
      end
      snacks.files({ dirs = { item.file } })
    end,
  })
end

-- Command to trigger the plugin
vim.api.nvim_create_user_command("SelectGitRepo", select_git_repo, {})
