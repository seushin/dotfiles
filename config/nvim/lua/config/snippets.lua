local util = require("util")
local luasnip = require("luasnip")

luasnip.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  -- updateevents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").load({ path = { '~/.config/nvim/my-snippets' } })
-- require("luasnip/loaders/from_vscode").lazy_load()

util.smap("<C-j>", "<cmd>lua require('luasnip').jump(1)<CR>")
util.smap("<C-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
