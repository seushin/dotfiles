local util = require("util")

vim.o.timeoutlen = 500

-- Resize window using <ctrl> arrow keys
util.nnoremap("<S-Up>", ":resize +2<CR>")
util.nnoremap("<S-Down>", ":resize -2<CR>")
util.nnoremap("<S-Left>", ":vertical resize -2<CR>")
util.nnoremap("<S-Right>", ":vertical resize +2<CR>")

-- Switch buffers with tab
util.nnoremap("]b", ":BufferLineCycleNext<CR>")
util.nnoremap("[b", ":BufferLineCyclePrev<CR>")
util.nnoremap("<leader>bd", ":bd<CR>")

-- no highlight
util.nnoremap("<CR>", ":noh<CR><CR>")

-- nvim-tree toggle
util.nnoremap("<leader>k", ":NvimTreeToggle<CR>")

-- git status
util.nnoremap("<leader>gs", ":Neogit<CR>")

-- windows to close with "q"
vim.cmd([[autocmd FileType help,lspinfo,git nnoremap <buffer><silent> q :close<CR>]])
vim.cmd([[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]])
