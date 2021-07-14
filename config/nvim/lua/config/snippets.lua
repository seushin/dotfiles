local util = require("util")
local luasnip = require("luasnip")

luasnip.config.set_config({
  history = true,
  -- Update more often, :h events for more info.
  -- updateevents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").load({ path = { '~/.config/nvim/my-snippets' } })
-- require("luasnip/loaders/from_vscode").lazy_load()

util.imap("<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { expr = true })
util.smap("<Tab>", "<cmd>lua require('luasnip').jump(1)<Cr>")
util.imap("<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>")
util.smap("<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>")
