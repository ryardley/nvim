return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.register({
			name = "alejandra",
			method = null_ls.methods.FORMATTING,
			filetypes = { "nix" }, -- explicitly state filetypes
			generator = null_ls.formatter({
				command = "alejandra",
				to_stdin = true,
			}),
		})

		null_ls.setup({
			debug = true,
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.rustfmt,
				null_ls.builtins.formatting.alejandra,
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
