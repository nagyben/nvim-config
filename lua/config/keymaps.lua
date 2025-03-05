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
vim.keymap.set({ "n" }, "<leader>gr", "<cmd>SelectGitRepo<CR>", { desc = "Find git repo by name" })

-- vim.keymap.set("n", "<leader><leader>", function()
--   require("telescope").extensions.smart_open.smart_open()
-- end, { noremap = true, silent = true })

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
