-- implements inactive window shading
return {
  "miversen33/sunglasses.nvim",
  config = function()
    local sunglasses_options = {
      filter_percent = 0.3,
      filter_type = "SHADE",
    }
    require("sunglasses").setup(sunglasses_options)
  end,
}
