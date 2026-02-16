return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
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
            "--case-sensitive",
            "--glob=!.git/*",
            "--glob=!node_modules/*",
            "--glob=!*.lock",
            "--glob=!package-lock.json",
          },
          mappings = {
            n = {
              ["<C-d>"] = require("telescope.actions").delete_buffer,
            },
            i = {
              ["<C-h>"] = "which_key",
              ["<C-d>"] = require("telescope.actions").delete_buffer,
              ["<C-f>"] = require("telescope.actions").to_fuzzy_refine,
            },
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", function()
        require("telescope.builtin").find_files({
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "--glob", "!node_modules/*" },
        })
      end, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })

      vim.keymap.set("n", "<leader>fg", function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end, { desc = "Live grep with args" })

      vim.api.nvim_set_keymap(
        "v",
        "<leader>fg",
        [[y<ESC><cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ default_text = vim.fn.escape(vim.fn.getreg('"'), '[](){}') })<CR>]],
        { noremap = true, silent = true }
      )

      require("telescope").load_extension("ui-select")
    end,
  },
}
