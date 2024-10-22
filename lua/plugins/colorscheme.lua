return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      color_overrides = {
        latte = {
          base = "#ff0000",
          mantle = "#242424",
          crust = "#474747",
        },
        frappe = {},
        macchiato = {},
        mocha = {},
      },
    },
  },
  {
    "rockyzhang24/arctic.nvim",
    branch = "v2",
    dependencies = { "rktjmp/lush.nvim" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  { "rebelot/kanagawa.nvim" },
}
