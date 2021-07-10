local util = require("util")

local M = {}

function M.setup(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  util.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  util.nnoremap("[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  util.nnoremap("]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  util.nnoremap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  util.nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
end

return M
