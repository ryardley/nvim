return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- load before other plugins so colors apply correctly
  enabled = false,
  config = function()
    require("gruvbox").setup({
      contrast = "", -- "hard", "soft", or "" for medium
      transparent_mode = false,
    })
    vim.o.background = "dark" -- or "light"
    vim.cmd.colorscheme("gruvbox")
  end,
}
