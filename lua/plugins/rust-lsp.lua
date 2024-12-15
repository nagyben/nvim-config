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
        for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
          local default_diagnostic_handler = vim.lsp.handlers[method]
          vim.lsp.handlers[method] = function(err, result, context, config)
            if err ~= nil and err.code == -32802 then
              return
            end
            return default_diagnostic_handler(err, result, context, config)
          end
        end
        return true
      end,
    },
  },
}
