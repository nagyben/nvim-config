return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    -- Your options go here
    -- name = "venv",
    -- auto_refresh = false
  },
  branch = "regexp", -- This is the regexp branch, use this for the new version
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    { "<leader>cV", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" },
    { "<leader>cv", "<cmd>:VenvSelectCached<cr>", desc = "Select VirtualEnv (cached)" },
  },
}
