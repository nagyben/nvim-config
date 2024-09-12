return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
      },
      position = "right",
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
      bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
      -- follow_current_file = { enabled = true },
      -- cwd_target = {
      --   sidebar = "tab", -- sidebar is when position = left or right
      --   current = "window", -- current is when position = current
      --   -- sidebar = "global",
      --   -- current = "global",
      -- },
    },
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          -- auto close
          -- vim.cmd("Neotree close")
          -- OR
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
