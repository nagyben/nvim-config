-- implements inactive window shading
return {
  "miversen33/sunglasses.nvim",
  config = function()
    local sunglasses_options = {
      filter_percent = 0.4,
      filter_type = "NOSYNTAX",
    }
    require("sunglasses").setup(sunglasses_options)
  end,
}
