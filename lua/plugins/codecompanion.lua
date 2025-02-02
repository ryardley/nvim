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
          adapter = "qwencoder",
        },
        inline = {
          adapter = "qwencoder",
        },
      },
      adapters = {
        llamacode = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "llamacode",
            env = {
              api_key = "ollama",
              url = env.LLAMACODE_URL,
            },
            schema = {
              model = {
                default = "llama3:latest",
              },
            },
          })
        end,
        deepseekcoder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "deepseekcoder",
            env = {
              api_key = "ollama",
              url = env.LLAMACODE_URL,
            },
            schema = {
              model = {
                default = "deepseek-coder:33b",
              },
            },
          })
        end,
        qwencoder = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwencoder",
            env = {
              api_key = "ollama",
              url = env.LLAMACODE_URL,
            },
            schema = {
              model = {
                default = "qwen2.5-coder:32b",
              },
            },
          })
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
