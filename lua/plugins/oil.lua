return {
  "stevearc/oil.nvim",
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["<C-l>"] = false,
        ["<M-l>"] = { "actions.refresh" },
        ["<M-s>"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Open the entry in a vertical split",
        },
        ["<M-h>"] = {
          "actions.select",
          opts = { horizontal = true },
          desc = "Open the entry in a horizontal split",
        },
        ["<M-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
      },
    })

    -- Create autocmd to override Oil's default navigation keys
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        local nvim_tmux_nav = require("nvim-tmux-navigation")
        vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { buffer = true })
        vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { buffer = true })
        vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { buffer = true })
        vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { buffer = true })
        vim.keymap.set("n", " ", require("oil").select, { buffer = true, nowait = true })
      end,
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory", noremap = true, silent = true })
  end,
}
