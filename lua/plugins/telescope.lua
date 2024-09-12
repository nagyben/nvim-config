return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!{**/.git/*,**/node_modules/*,**/.venv/*,**/*.lock.hcl}",
      },
    },
    extensions = {
      repo = {
        settings = {
          auto_lcd = true,
        },
      },
    },
  },
}
