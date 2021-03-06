local packer = nil

local function init()
  if packer == nil then
    packer = require("packer")
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()

  -- Packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim", opt = true }

  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "nvim-lua/popup.nvim", module = "popup" }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      "nvim-lua/plenary.nvim",
      "folke/lua-dev.nvim",
      "jose-elias-alvarez/nvim-lsp-ts-utils",
    },
    config = function()
      require("config.lsp")
    end,
  }

  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  }
  use "rafamadriz/friendly-snippets"
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("config.snippets")
    end,
  }
  use {
    "hrsh7th/nvim-compe",
    requires = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("config.compe")
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('config.treesitter')
    end,
  }
  use "windwp/nvim-ts-autotag"

  use {
    "b3nj5m1n/kommentary",
    config = function()
      require("config.comments")
    end,
  }

  -- Theme: color schemes
  use {
    "morhetz/gruvbox",
    event = "VimEnter",
    config = function()
      require("config.theme")
    end,
  }

  -- Theme: icons
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires = { "nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    keys = "<leader>k",
    config = function()
      require("config.nvim-tree")
    end,
  }

  use { "junegunn/fzf", run = "./install --all" }
  use { "junegunn/fzf.vim" }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Fuzzy finder
  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    keys = { "<leader><space>", "<leader>f", "<C-p>" },
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
  }

  -- Tabs
  use {
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    requires = "nvim-web-devicons",
    config = function()
      require("config.bufferline")
    end,
  }

  -- Terminal
  use {
    "akinsho/nvim-toggleterm.lua",
    keys = "<C-t>",
    config = function()
      require("config.terminal")
    end,
  }

  -- Git Gutter
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  }
  use {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    keys = "<leader>gs",
    config = function()
      require("config.neogit")
    end,
  }

  -- Statusline
  use {
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config.lualine")
    end,
    requires = "nvim-web-devicons",
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("config.colorizer")
    end,
  }

  use {
    "RRethy/vim-illuminate",
    module = "illuminate",
    config = function()
      vim.g.Illuminate_delay = 1000
    end,
  }

  use "tpope/vim-fugitive"
  use "tpope/vim-surround"
  use "christoomey/vim-tmux-navigator"
  use "seushin/42header.vim"
  use "mhinz/vim-startify"
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
