return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  lazy = false,
  keys = {
    { "cv", "<cmd>VenvSelect<cr>" },
    { "cV", "<cmd>VenvSelect<cr>" },
  },
}
