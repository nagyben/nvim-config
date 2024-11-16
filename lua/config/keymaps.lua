-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "<leader>j", "'J'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n", "v" }, "J", "'5j'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n", "v" }, "K", "'5k'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n" }, "gh", vim.lsp.buf.hover, { silent = true, noremap = true })
-- vim.keymap.set({ "n" }, "<leader>fG", "<cmd>Telescope live_grep<CR>", { desc = "Live grep file contents" })
vim.keymap.set(
  { "n" },
  "<leader>fG",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "Live grep file contents" }
)

-- Note: we are using lolcate-rs to build the index for Telescope repo cached_list
-- see https://github.com/ngirard/lolcate-rs
vim.keymap.set({ "n" }, "<leader>gr", "<cmd>Telescope repo cached_list<CR>", { desc = "Find git repo by name" })

vim.keymap.set("n", "<leader><leader>", function()
  require("telescope").extensions.smart_open.smart_open()
end, { noremap = true, silent = true })

local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
vim.keymap.set({ "!", "", "l" }, "<c-`>", lazyterm, { desc = "Terminal (Root Dir)" })
vim.keymap.set("t", "<c-`>", "<cmd>close<cr>", { desc = "Close Terminal" })
vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>", { desc = "Open URL under cursor" })

-- prevent shift key escape characters in terminal mode
vim.keymap.set("t", "<s-space>", "<space>", {})
vim.keymap.set("t", "<s-enter>", "<enter>", {})

local wk = require("which-key")
-- As an example, we will create the following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register({
  g = {
    name = "git",
    h = {
      name = "github",
      o = { "<cmd>!gh repo view --web<cr>", "Open repo in browser" }, -- create a binding with label
    },
  },
  O = {
    name = "Octo",
    p = {
      name = "Pull requests",
      l = { "<cmd>Octo pr list<CR>", "List pull requests in current repo" },
      o = { "<cmd>Octo pr browser<CR>", "Open pull request in browser" },
      C = { "<cmd>Octo pr checks<cr>", "Show checks status for PR" },
    },
  },
}, { prefix = "<leader>" })

vim.filetype.add({
  extension = {
    avsc = "json",
  },
})
