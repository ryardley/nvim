return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      "kristijanhusak/vim-dadbod-ui",
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.keymap.set('n', '<leader>db', '<Cmd>DBUIToggle<CR>', {
        desc = "Toggle DBUI",
        silent = true,
      })
    end,
  },
}
