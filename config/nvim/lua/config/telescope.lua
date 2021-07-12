local telescope = require("telescope")
local actions = require("telescope.actions")
local util = require("util")

telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    -- entry_prefix = "  ",
    -- initial_mode = "insert",
    winblend = 0,
    selection_strategy = "reset",
    sorting_strategy = "descending",
    color_devicons = true,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        -- width_padding = 0.1,
        -- height_padding = 0.1,
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = {
        -- width_padding = 0.05,
        -- height_padding = 1,
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },
      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },

    -- file_ignore_patterns = {},
    -- vimgrep_arguments = {
    --   'rg',
    --   '--color=never',
    --   '--no-heading',
    --   '--with-filename',
    --   '--line-number',
    --   '--column',
    --   '--smart-case'
    -- },
  },
})

telescope.load_extension("fzf")

local function project_files(opts)
  opts = opts or {}

  if vim.v.shell_error ~= 0 then
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
    return
  end

  require("telescope.builtin").git_files(opts)
end

util.nnoremap("<Leader><Space>", require("telescope.builtin").find_files)
util.nnoremap("<C-p>", project_files)
util.nnoremap("<leader>f", require("telescope.builtin").live_grep)
