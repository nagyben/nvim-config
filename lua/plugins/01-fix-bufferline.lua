-- TODO: delete this file when https://github.com/LazyVim/LazyVim/issues/6355 is merged
return {
  "catppuccin/nvim",
  opts = function(_, opts)
    local module = require("catppuccin.groups.integrations.bufferline")
    if module then
      module.get = module.get_theme
    end
    return opts
  end,
}
