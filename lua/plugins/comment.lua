return {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10.0") == 1,
  keys = {
    { "<leader>/", "gcc", mode = "n", remap = true, silent = true, desc = "Toggle comment" },
    { "<leader>/", "gc",  mode = "v", remap = true, silent = true, desc = "Toggle comment" },
  },
}
