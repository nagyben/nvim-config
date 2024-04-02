-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Configure autosave (see :h events for BufLeave and FocusLost)
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  command = "silent! wa",
})
