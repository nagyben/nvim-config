-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "<leader>j", "'J'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n", "v" }, "J", "'5j'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n", "v" }, "K", "'5k'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n" }, "gh", vim.lsp.buf.hover, { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>fG", "<cmd>Telescope live_grep<CR>", { desc = "Live grep file contents" })
vim.keymap.set({ "n" }, "<leader><space>", "<cmd>Telescope file_browser<CR>", { desc = "Live file browser" })

local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
vim.keymap.set({ "!", "", "l" }, "<c-`>", lazyterm, { desc = "Terminal (Root Dir)" })
vim.keymap.set("t", "<c-`>", "<cmd>close<cr>", { desc = "Close Terminal" })
vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>", { desc = "Open URL under cursor" })

-- prevent shift key escape characters in terminal mode
vim.keymap.set("t", "<s-space>", "<space>", {})
vim.keymap.set("t", "<s-enter>", "<enter>", {})
