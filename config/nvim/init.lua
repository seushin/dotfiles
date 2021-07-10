vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("util")
require("options")
require("config.keys")

if require("util.download_packer")() then
	return
end

vim.defer_fn(function()
	require("plugins")
end, 0)
