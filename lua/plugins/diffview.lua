return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>dvo", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
    { "<leader>dvc", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
    { "<leader>dvh", "<cmd>DiffviewFileHistory<cr>", desc = "DiffView File History" },
  },
  config = function()
    local actions = require("diffview.actions")
    require("diffview").setup({
      keymaps = {
        disable_defaults = false,
        view = {
          { "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },
        },
        file_panel = {
          { "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },
        },
        file_history_panel = {
          { "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },
        },
      },
    })
  end,
}
