-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"
vim.opt.expandtab = true
vim.opt.conceallevel = 0
vim.opt.scrolloff = 15
-- vim.g.root_spec = { "cwd" } -- https://github.com/LazyVim/LazyVim/discussions/2150
vim.g.root_spec = { ".git" }
vim.g.snacks_animate = false
vim.diagnostic.config({ virtual_lines = { current_line = true } })
vim.g.lazyvim_python_lsp = "ty"
