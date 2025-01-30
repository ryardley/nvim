local u = require("utils")
return {
  "alexghergh/nvim-tmux-navigation",
  lazy = false,
  config = function()
    local nvim_tmux_nav = require("nvim-tmux-navigation")

    nvim_tmux_nav.setup({
      disable_when_zoomed = true, -- defaults to false
    })

    local o = { noremap = true, silent = false }
    vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, u.merge({ desc = "Tmux Navigate Left" }, o))
    vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, u.merge({ desc = "Tmux Navigate Down" }, o))
    vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, u.merge({ desc = "Tmux Navigate Up" }, o))
    vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, u.merge({ desc = "Tmux Navigate Right" }, o))
    vim.keymap.set(
      "n",
      "<C-\\>",
      nvim_tmux_nav.NvimTmuxNavigateLastActive,
      u.merge({ desc = "Tmux Navigate Last Active" }, o)
    )
    vim.keymap.set(
      "n",
      "<C-Space>",
      nvim_tmux_nav.NvimTmuxNavigateNext,
      u.merge({ desc = "Tmux Navigate Next" }, o)
    )
  end,
}
