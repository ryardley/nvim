return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					-- Add or modify the defaults table
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--case-sensitive", -- Add this line to enforce case sensitivity
					},
          mappings = {
            n = {
              ['<C-d>'] = require('telescope.actions').delete_buffer
            },
            i = {
              ["<C-h>"] = "which_key",
              ['<C-d>'] = require('telescope.actions').delete_buffer
            }
          }
				},
      })
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", function()
				require("telescope.builtin").find_files({
					find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "--glob", "!node_modules/*" },
				})
			end, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = 'Live grep'})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers' })

			-- New function for selecting folder then live grep
			local function live_grep_in_selected_folder()
				builtin.find_files({
					prompt_title = "Select Folder for Live Grep",
					find_command = { "fd", "--type", "d" }, -- List only directories
					attach_mappings = function(prompt_bufnr, map)
						local select_folder = function()
							local selection = require("telescope.actions.state").get_selected_entry()
							require("telescope.actions").close(prompt_bufnr)
							if selection then
								builtin.live_grep({
									prompt_title = "Live Grep in " .. selection.value,
									search_dirs = { selection.value },
								})
							end
						end
						map("i", "<CR>", select_folder)
						map("n", "<CR>", select_folder)
						return true
					end,
				})
			end

      -- from claude live grep over selection
      vim.api.nvim_set_keymap('v', '<leader>fg', [[y<ESC><cmd>lua require('telescope.builtin').live_grep({ default_text = vim.fn.escape(vim.fn.getreg('"'), '[](){}') })<CR>]], { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>fgg", live_grep_in_selected_folder, { desc = "Select folder then live grep" })

			require("telescope").load_extension("ui-select")
		end,
	},
}
