local util = require("util")

vim.o.completeopt = "menuone,noselect"

require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable", -- changed to "enable" to prevent auto select
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = false,
    luasnip = true,
    treesitter = false,
    emoji = true,
    spell = true,
  },
})

local function check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

local function complete()
  if vim.fn.pumvisible() == 1 then
    return vim.fn["compe#confirm"]({ keys = "<cr>", select = true })
  else
    return require("nvim-autopairs").autopairs_cr()
  end
end

local function tab_complete()
  if vim.fn.pumvisible() == 1 then
    return util.t "<C-n>"
  elseif require("luasnip").expand_or_jumpable() then
    return util.t "<cmd>lua require('luasnip').jump(1)<CR>"
  elseif check_back_space() then
    return util.t "<C-j>"
  else
    return vim.fn["compe#complete"]()
  end
end

local function s_tab_complete()
  if vim.fn.pumvisible() == 1 then
    return util.t "<C-p>"
  elseif require("luasnip").jumpable(-1) then
    return util.t "<cmd>lua require'luasnip'.jump(-1)<Cr>"
  else
    return util.t "<C-k>"
  end
end

local expr = { expr = true, silent = true }

util.imap("<CR>", complete, expr)
util.inoremap("<C-Space>", "compe#complete()", expr)
util.inoremap("<C-e>", "compe#close('<C-e>')", expr)
util.imap ("<C-j>", tab_complete, expr)
util.imap("<C-k>", s_tab_complete, expr)
