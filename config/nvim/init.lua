require("util")
require("options")

if require("util.download_packer")() then
	return
end

vim.defer_fn(function()
	require("plugins")
end, 0)
