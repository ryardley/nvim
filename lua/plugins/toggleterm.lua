return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    -- Example custom keymapping for specific terminal tasks
    -- Open a floating terminal with <leader>tf
    map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)
    -- Open a vertical terminal with <leader>tv
    map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", opts)
    -- Open a horizontal terminal with <leader>th
    map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal size=15<CR>", opts)
  end,
}
