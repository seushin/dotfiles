require("toggleterm").setup {
  size = 12,
  hide_numbers = true,
  open_mapping = [[<leader>t]],
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  persist_size = true,
  direction = "horizontal",
}

-- Hide number column for
-- vim.cmd [[au TermOpen * setlocal nonumber norelativenumber]]

-- Esc twice to get to normal mode
vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])
