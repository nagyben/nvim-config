-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "J", "'5j'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n", "v" }, "K", "'5k'", { expr = true, silent = true, remap = false })
vim.keymap.set({ "n" }, "gh", vim.lsp.buf.hover, { silent = true, noremap = true })
