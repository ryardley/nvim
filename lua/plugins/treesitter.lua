return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "rust",
      "python",
      "solidity",
      "circom",
      "nix",
      "comment",
      "dockerfile",
      "diff",
      "gitcommit",
      "gitignore",
      "query",
      "regex",
    })

    -- Start treesitter highlighting for any filetype that has a parser installed.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- Experimental treesitter-based indentation for YAML.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "yaml" },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
