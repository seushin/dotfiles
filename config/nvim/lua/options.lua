local cmd = vim.cmd

--[[ vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.shiftwidth = indent -- Size of an indent
vim.bo.smartindent = true -- Insert indents automatically
vim.bo.undofile = true ]]

vim.opt.autowrite = true -- enable auto write
vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.shiftround = true -- Round indent
vim.opt.joinspaces = false -- No double spaces with join after a dot

vim.opt.clipboard = "unnamed" -- sync with system clipboard
vim.opt.grepprg = "rg --vimgrep --no-heading"
vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.undofile = true

vim.opt.title = true
vim.opt.mouse = "a" -- enable mouse mode
vim.guicursor = ""
vim.opt.number = true -- Print line number
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.showmode = false -- dont show mode since we have a statusline
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.cmdheight = 1
vim.opt.scrolloff = 8 -- Lines of context

vim.opt.wrap = false -- Disable line wrap
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.termguicolors = true -- True color support

vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.listchars = "tab:→ "
