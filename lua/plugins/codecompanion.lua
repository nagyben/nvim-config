return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
  },
  config = true,
  opts = {
    adapters = {
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = "insert your key here",
          },
        })
      end,
    },
  },
  keys = {
    { "<leader>CCC", "<cmd>:CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
    { "<leader>CCA", "<cmd>:CodeCompanionActions<cr>", desc = "CodeCompanion Chat" },
  },
}
