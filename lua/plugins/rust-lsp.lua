return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          linkedProjects = {},
          diagnostics = {
            disabled = { "proc-macro-disabled" },
          },
        },
      },
    },
  },
}
