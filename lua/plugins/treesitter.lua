return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  main = "nvim-treesitter.configs",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    ensure_installed = {
      "yaml",
    },
  },
}
