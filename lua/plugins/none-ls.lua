return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- none-ls has no rustfmt builtin, so register it manually.
    null_ls.register({
      name = "rustfmt",
      method = null_ls.methods.FORMATTING,
      filetypes = { "rust" },
      generator = null_ls.formatter({
        command = "rustfmt",
        args = { "--edition", "2021" },
        to_stdin = true,
      }),
    })

    null_ls.setup({
      debug = false,
      sources = {
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.alejandra,
      },
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ timeout_ms = 3000 })
    end, { desc = "Format buffer" })

    -- Format on save, but only when a client that supports formatting is attached.
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        local bufnr = args.buf
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          if client:supports_method("textDocument/formatting") then
            vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
            return
          end
        end
      end,
    })
  end,
}
