return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {
      preview = {
        filetypes = {
          "md",
          "markdown",
          "norg",
          "rmd",
          "org",
          "vimwiki",
          "typst",
          "latex",
          "quarto",
          "Avante",
          "codecompanion",
        },
        ignore_buftypes = {},

        condition = function(buffer)
          local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt

          if bt == "nofile" and ft == "codecompanion" then
            return true
          elseif bt == "nofile" then
            return true
          else
            return true
          end
        end,
      },
      source = true,
      dependencies = {
        "saghen/blink.cmp",
      },
    },
  },
}
