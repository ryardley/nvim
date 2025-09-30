-- local rust_src_path = os.getenv("RUST_SRC_PATH")
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = false

    -- Add folding capabilities required by ufo.nvim
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    vim.lsp.config('ts_ls', {
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
    })
    vim.lsp.config('html', {
      cmd = { 'vscode-html-language-server', '--stdio' },
      filetypes = { 'html' },
      root_markers = { 'package.json', '.git' },
    })

    vim.lsp.config('lua_ls', {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', 'stylua.toml', '.git' },
    })

    vim.lsp.config('rust_analyzer', {
      cmd = { "rust-analyzer" },
      filetypes = { 'rust' },
      root_markers = { 'Cargo.toml', 'Cargo.lock', '.git' },
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

    vim.lsp.config('circom-lsp', {
      cmd = { 'circom-lsp' },
      filetypes = { 'circom' },
      root_markers = { '.git' },
    })


    vim.lsp.config('pyright', {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
      settings = {
        python = {
          pythonPath = vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python"),
          venvPath = vim.env.VIRTUAL_ENV,
        },
      },
    })

    vim.lsp.config('mdx_analyzer', {
      cmd = {
        "npx",
        "--yes",
        "@mdx-js/language-server",
        "mdx-language-server",
        "--stdio",
      },
      filetypes = { "markdown.mdx" },
      root_markers = { 'package.json', '.git' },
    })

    vim.lsp.config('solidity', {
      cmd = {
        "pnpx",
        "@nomicfoundation/solidity-language-server",
        "--stdio",
      },
      filetypes = { "solidity" },
      root_markers = {
        "hardhat.config.js",
        "hardhat.config.ts",
        "foundry.toml",
        "remappings.txt",
        "truffle.js",
        "truffle-config.js",
        "ape-config.yaml",
        "package.json",
        ".git",
      },
    })

    vim.lsp.enable({
      'ts_ls',
      'html',
      'lua_ls',
      'rust_analyzer',
      'circom-lsp',
      'pyright',
      'mdx_analyzer',
      'solidity',
    })

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
