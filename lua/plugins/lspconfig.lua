-- local rust_src_path = os.getenv("RUST_SRC_PATH")
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")
    local util = require("lspconfig.util")

    capabilities.textDocument.completion.completionItem.snippetSupport = false

    -- Add folding capabilities required by ufo.nvim
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
    })

    lspconfig.html.setup({
      capabilities = capabilities,
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      cmd = { "rust-analyzer" },
      settings = {
        ["rust-analyzer"] = {
          cache = {
            warmup = true,
          },
          inlayHints = {
            typeHints = {
              enable = true,
            },
            parameterHints = {
              enable = true,
            },
            chainingHints = {
              enable = true,
            },
          },
          -- Increase memory limits
          lruCapacity = 1000,
          maxInlayHintLength = 50,
        },
      },
    })

    lspconfig["circom-lsp"].setup({
      capabilities = capabilities,
    })

    lspconfig.pyright.setup({
      capabilities = capabilities,
      settings = {
        python = {
          pythonPath = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python"),
          venvPath = vim.env.VIRTUAL_ENV,
        },
      },
    })

    -- lspconfig.marksman.setup({
    --   capabilities = capabilities,
    --   default_config = {
    --     filetypes = { "markdown" },
    --     cmd = { "marksman", "server" }
    --   },
    -- })

    lspconfig.mdx_analyzer.setup({
      capabilities = capabilities,
      cmd = {
        "npx",
        "--yes",
        "@mdx-js/language-server",
        "mdx-language-server",
        "--stdio",
      },

      default_config = {
        filetypes = { "markdown.mdx" },
        cmd = {
          "npx",
          "--yes",
          "@mdx-js/language-server",
          "mdx-language-server",
          "--stdio",
        },
      },
    })

    local root_files = {
      "hardhat.config.js",
      "hardhat.config.ts",
      "foundry.toml",
      "remappings.txt",
      "truffle.js",
      "truffle-config.js",
      "ape-config.yaml",
    }
    configs.solidity = {
      default_config = {
        cmd = {
          "pnpx",
          "@nomicfoundation/solidity-language-server",
          "--stdio",
        },
        filetypes = { "solidity" },
        root_dir = util.root_pattern(unpack(root_files)) or util.root_pattern(".git", "package.json"),
        single_file_support = true,
      },
    }

    lspconfig.solidity.setup({})

    -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, noremap = true, silent = true }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        -- -- Add rust_analyzer inlay_hints
        -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- if client and client.name == "rust_analyzer" then
        -- 	vim.lsp.inlay_hint.enable(true)
        -- end

        -- toggle hints
        vim.keymap.set("n", "<leader>th", function()
          local enabled = vim.lsp.inlay_hint.is_enabled()
          vim.lsp.inlay_hint.enable(not enabled)
        end, { desc = "Toggle inlay hints" })
      end,
    })
  end,
}
