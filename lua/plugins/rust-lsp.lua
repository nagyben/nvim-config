return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      rust_analyzer = {},
      taplo = {
        keys = {
          {
            "gh",
            function()
              if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                require("crates").show_popup()
              else
                vim.lsp.buf.hover()
              end
            end,
            desc = "Show Crate Documentation",
          },
        },
      },
    },
    setup = {
      rust_analyzer = function()
        return true
      end,
    },
  },
}
