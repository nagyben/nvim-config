return {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = {
    {
      "<leader><space>",
      ":Telescope file_browser path=%:p:h=%:p:h<cr>",
      desc = "Browse files",
    },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = "~/.config/nvim" })
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>fL",
      function()
        require("telescope.builtin").live_grep({ cwd = "~/.local/share/nvim" })
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").find_files({ cwd = "~" })
      end,
      desc = "Find files in home dir",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
