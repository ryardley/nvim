return {
  "arnamak/stay-centered.nvim",
  lazy = false,
  keys = {
    {
      "<leader>st",
      function()
        require("stay-centered").toggle()
      end,
      desc = "Toggle stay-centered.nvim",
    },
  },
  opts = {
    enabled = true,
    allow_scroll_move = false,
    skip_filetypes = {},
  },
  config = function(_, opts)
    require("stay-centered").setup(opts)
  end,
}
