local util = require("util")

require("toggleterm").setup {
  size = 12,
  hide_numbers = true,
  open_mapping = [[<C-t>]],
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  persist_size = true,
  direction = "horizontal",
}

-- Esc twice to get to normal mode
util.tnoremap("<Esc><Esc>", "<C-\\><C-n><C-w><C-p>")
