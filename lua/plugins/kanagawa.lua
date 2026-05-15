return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      theme = "dragon", -- "wave" (default), "dragon", or "lotus" (light)
      background = {
        dark = "dragon",
        light = "lotus",
      },
      transparent = false,
      dimInactive = false,
    })
    vim.cmd.colorscheme("kanagawa-dragon")
  end,
}
