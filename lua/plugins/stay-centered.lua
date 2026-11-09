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
    skip_filetypes = { "lua", "typescript" },
  },
  config = function(_, opts)
    require("stay-centered").setup(opts)
  end,
}
