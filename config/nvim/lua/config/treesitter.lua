require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "go",
    "graphql",
    "html",
    "javascript",
    "jsonc",
    "lua",
    "python",
    "regex",
    "rust",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "yaml",
    "json",
    "markdown",
  },
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = false },
  context_commentstring = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-r>",
    },
  },
})
