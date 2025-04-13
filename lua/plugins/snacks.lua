return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    notifier = {
      -- your notifier configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      top_down = false,
    },
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          auto_close = true,
        },
      },
    },
  },
}
