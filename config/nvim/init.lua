vim.g.mapleader = " "

require("util")
require("options")
require("config.keys")

if require("util.download_packer")() then
	return
end

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
vim.cmd([[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]])
vim.cmd([[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]])
vim.cmd([[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]])
vim.cmd([[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]])
vim.cmd([[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]])
