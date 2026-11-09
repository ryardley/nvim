return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "linrongbin16/lsp-progress.nvim" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
      },
      sections = {
        lualine_x = {
          function()
            return require("lsp-progress").progress()
          end,
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    })

    -- Refresh lualine when LSP progress updates.
    vim.api.nvim_create_augroup("lualine_lsp_progress", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_lsp_progress",
      pattern = "LspProgressStatusUpdated",
      callback = function()
        require("lualine").refresh()
      end,
    })
  end,
}
