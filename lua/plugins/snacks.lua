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
  keys = {
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (open)",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({ state = "all" })
      end,
      desc = "GitHub Issues (all)",
    },
    {
      "<leader>gp",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (open)",
    },
    {
      "<leader>gP",
      function()
        Snacks.picker.gh_pr({ state = "all" })
      end,
      desc = "GitHub Pull Requests (all)",
    },
  },
}
