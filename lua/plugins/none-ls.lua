return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    -- Register custom rustfmt formatter
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
      debug = true,
      sources = {
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.alejandra,
        -- rustfmt is now registered above, not as a builtin
      },
    })

    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ timeout_ms = 3000 })
    end, {})

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 3000 })
      end,
    })
  end,
}
