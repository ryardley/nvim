return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "ryardley/mouser.nvim" }, -- Add this line
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
      },
      sections = {
        lualine_x = {
          _G.mouser_status,
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    })
  end,
}
