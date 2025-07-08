return {
  "numToStr/Comment.nvim",
  dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })

    vim.keymap.set("n", "<leader>/", function()
      require("Comment.api").toggle.linewise.current()
    end, { noremap = true, silent = true })
    vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
  end,
}
