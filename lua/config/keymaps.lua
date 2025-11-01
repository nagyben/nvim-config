-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "<leader>j", "'J'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n", "v" }, "J", "'5j'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n", "v" }, "K", "'5k'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n" }, "gh", vim.lsp.buf.hover, { silent = true, noremap = true })
vim.keymap.set({ "n" }, ";", "mmA;<Esc>`m", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<c-/>", "gcc", { desc = "Toggle comment", silent = true, remap = false })
-- vim.keymap.set({ "n" }, "<leader>fG", "<cmd>Telescope live_grep<CR>", { desc = "Live grep file contents" })

-- Note: we are using lolcate-rs to build the index for Telescope repo cached_list
-- see https://github.com/ngirard/lolcate-rs
vim.keymap.set({ "n" }, "<leader>gr", "<cmd>SelectGitRepo<CR>", { desc = "Find git repo by name" })
-- vim.keymap.set({ "n" }, "<leader>gp", "<cmd>SelectGithubPullRequest<CR>", { desc = "Open pull request" })

vim.keymap.set("n", "<leader>uv", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>", { desc = "Open URL under cursor" })

-- prevent shift key escape characters in terminal mode
vim.keymap.set("t", "<s-space>", "<space>", {})
vim.keymap.set("t", "<s-enter>", "<enter>", {})

-- for these to work you have to set the keymap in the iTerm key bindings
-- these are the up/down/left/right arrow emojis
-- see https://unicode.party/
vim.keymap.set("n", "⬆️", "<cmd>Treewalker Up<CR>", { desc = "Treewalker Up", noremap = true })
vim.keymap.set("n", "⬇️", "<cmd>Treewalker Down<CR>", { desc = "Treewalker Down", noremap = true })
vim.keymap.set("n", "➡️", "<cmd>Treewalker Right<CR>", { desc = "Treewalker Right", noremap = true })
vim.keymap.set("n", "⬅️", "<cmd>Treewalker Left<CR>", { desc = "Treewalker Left", noremap = true })

local wk = require("which-key")
wk.add({
  { "<leader>O", group = "Octo" },
  { "<leader>Op", group = "Pull requests" },
  { "<leader>OpC", "<cmd>Octo pr checks<cr>", desc = "Show checks status for PR" },
  { "<leader>Opl", "<cmd>Octo pr list<CR>", desc = "List pull requests in current repo" },
  { "<leader>Opo", "<cmd>Octo pr browser<CR>", desc = "Open pull request in browser" },
  { "<leader>g", group = "git" },
  { "<leader>gh", group = "github" },
  { "<leader>gho", "<cmd>!gh repo view --web<cr>", desc = "Open repo in browser" },
})

vim.filetype.add({
  extension = {
    avsc = "json",
  },
})
-- vim.keymap.set("i", "<c-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
