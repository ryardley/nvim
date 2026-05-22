return {
  {
    "catppuccin/nvim",
    lazy = false,
    enabled = false,
    name = "catppuccin",
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
