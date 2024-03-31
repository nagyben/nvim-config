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
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
