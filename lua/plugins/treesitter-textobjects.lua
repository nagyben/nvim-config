return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  opts = {
    textobjects = {
      swap = {
        enable = true,
        swap_next = {
          ["<leader>na"] = "@parameter.inner",
          ["],"] = "@array_expression.outer",
        },
        swap_previous = {
          ["<leader>nA"] = "@parameter.inner",
          ["[,"] = "@array_expression.outer",
        },
      },
    },
  },
}
