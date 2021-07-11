local util = require("util")

vim.g.nvim_tree_width = 40
-- empty by default
vim.g.nvim_tree_ignore = { ".git", "node_modules" }
-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
vim.g.nvim_tree_auto_open = 1
-- 0 by default, closes the tree when it's the last window
vim.g.nvim_tree_auto_close = 1
-- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_quit_on_open = 1
-- 0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify" }
vim.g.nvim_tree_indent_markers = 1
-- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_git_hl = 0
-- 1 by default, disables netrw
vim.g.nvim_tree_disable_netrw = 0
-- 0 by default, will show lsp diagnostics in the signcolumn.
vim.g.nvim_tree_lsp_diagnostics = 1

require("nvim-tree.events").on_nvim_tree_ready(function()
  vim.cmd("NvimTreeRefresh")
end)
