return {
  "aaronhallaert/advanced-git-search.nvim",
  cmd = { "AdvancedGitSearch" },
  config = function()
    require("advanced_git_search.snacks").setup({
      -- Browse command to open commits in browser. Default fugitive GBrowse.
      -- {commit_hash} is the placeholder for the commit hash.
      browse_command = "GBrowse {commit_hash}",
      -- when {commit_hash} is not provided, the commit will be appended to the specified command seperated by a space
      -- browse_command = "GBrowse",
      -- => both will result in calling `:GBrowse commit`

      -- fugitive or diffview
      diff_plugin = "diffview",
      -- customize git in previewer
      -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
      git_flags = {},
      -- customize git diff in previewer
      -- e.g. flags such as { "--raw" }
      git_diff_flags = {},
      git_log_flags = {},
      -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
      show_builtin_git_pickers = false,
      entry_default_author_or_date = "author", -- one of "author", "date" or "both"
      keymaps = {
        -- following keymaps can be overridden
        toggle_date_author = "<C-w>",
        open_commit_in_browser = "<C-o>",
        copy_commit_hash = "<C-y>",
        show_entire_commit = "<C-e>",
      },

      -- Telescope layout setup
      telescope_theme = {
        function_name_1 = {
          -- Theme options
        },
        function_name_2 = "dropdown",
        -- e.g. realistic example
        show_custom_functions = {
          layout_config = { width = 0.4, height = 0.4 },
        },
      },
    })
  end,
  dependencies = {
    "folke/snacks.nvim",
  },
}
