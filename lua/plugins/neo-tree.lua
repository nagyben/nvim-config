return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focued_file = {
      enable = true,
      update_root = true,
    },
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          -- '.git',
          -- '.DS_Store',
          -- 'thumbs.db',
        },
        never_show = {},
      },
    },
  },
}
