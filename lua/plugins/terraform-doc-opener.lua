return {
  { "Afourcat/treesitter-terraform-doc.nvim" },
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        terraformls = function()
          require("treesitter-terraform-doc").setup({})
        end,
      },
    },
  },
}
