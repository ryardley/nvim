local env = dofile(vim.fn.stdpath("config") .. "/.env.lua")

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "venice",
				},
				inline = {
					adapter = "venice",
				},
			},
			adapters = {
				venice = function()
					local adapter = require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = env.OPENAI_URL,
							api_key = env.API_KEY,
							chat_url = "/v1/chat/completions",
						},
						schema = {
							temperature = {
								mapping = "parameters",
							},
							top_p = {
								mapping = "parameters",
							},
							logit_bias = {
								mapping = "parameters",
							},
						},
					})
					local keys_to_remove = {
						"mirostat_eta",
						"mirostat",
						"num_ctx",
						"top_k",
						"tfs_z",
						"seed",
						"repeat_penalty",
						"repeat_last_n",
						"mirostat_tau",
						"num_predict",
					}

					for _, key in ipairs(keys_to_remove) do
						adapter.schema[key] = nil
					end
					return adapter
				end,
			},
		})
		vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
		vim.keymap.set(
			{ "n", "v" },
			"<Leader>a",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
