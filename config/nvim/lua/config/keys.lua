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

-- Clear search with <esc>
util.nnoremap("<CR>", ":noh<CR><CR>")

util.nnoremap("<leader><CR>", ":so ~/.config/nvim/init.lua<CR>")

util.nnoremap("<leader>k", ":NvimTreeToggle<CR>")

util.nnoremap("<leader>gs", ":Neogit<CR>")

-- telescope <ctrl-r> in command line
-- vim.cmd([[cmap <C-R> <Plug>(TelescopeFuzzyCommandSearch)]])

local function complete()
  if vim.fn.pumvisible() == 1 then
    return vim.fn["compe#confirm"]({ keys = "<cr>", select = true })
  else
    return require("nvim-autopairs").autopairs_cr()
  end
end

local opts = { expr = true, silent = true }

util.imap("<CR>", complete, opts)
util.inoremap("<C-Space>", "compe#complete()", opts)
util.inoremap("<C-e>", "compe#close('<C-e>')", opts)
util.inoremap ("<C-j>", "pumvisible() ? '<C-n>' : compe#complete()", opts)
util.inoremap("<C-k>", "pumvisible() ? '<C-p>' : '<C-k>'", opts)
