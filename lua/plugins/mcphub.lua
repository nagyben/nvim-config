-- return {}
return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- cmd = "MCPHub",
  -- build = "bundled_build.lua", -- Bundles mcp-hub locally
  build = "npm install -g mcp-hub@latest",
  config = function()
    require("mcphub").setup({
      auto_toggle_mcp_servers = true,
      port = 5999,
      config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Config file path
      extensions = {
        codecompanion = {
          -- Show the mcp tool result in the chat buffer
          show_result_in_chat = true,
          -- Make chat #variables from MCP server resources
          make_vars = true,
          -- Create slash commands for prompts
          make_slash_commands = true,
        },
      },
    })

    require("codecompanion").setup({
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    })
  end,
}
