return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  lazy = false,
  config = function()
    -- Function to check if running on NixOS
    local function is_nixos()
      local handle = io.open("/etc/os-release", "r")
      if not handle then
        return false
      end
      local content = handle:read("*a")
      handle:close()
      return content:match("ID=nixos") ~= nil
    end

    if not is_nixos() then
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "rounded",
        },
        max_concurrent_installers = 4,
      })

      -- Setup mason-lspconfig
      require("mason-lspconfig").setup({
        -- Servers that should be automatically installed
        ensure_installed = {
          "lua_ls",
          "tsserver", -- for ts_ls
          "html",
          "rust_analyzer",
          "pyright",
          "mdx_analyzer",
          -- Note: Some of your LSPs like circom-lsp and solidity
          -- might need manual installation or different setup
        },
        automatic_installation = not is_nixos(),
      })
    end
  end,
}
