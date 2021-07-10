vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
  -- Packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim", opt = true }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    config = function()
      require("config.lsp")
    end,
  }

  use {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("config.compe")
    end,
    requires = {
      {
        "windwp/nvim-autopairs",
        config = function()
          require("nvim-autopairs").setup()
        end,
      },
    },
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    opt = true,
    event = "BufRead",
    config = [[require('config.treesitter')]],
  }

  use {
    "b3nj5m1n/kommentary",
    opt = true,
    keys = { "gc" },
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

  -- use {
  --   "norcalli/nvim-terminal.lua",
  --   ft = "terminal",
  --   config = function()
  --     require("terminal").setup()
  --   end,
  -- })
  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "nvim-lua/popup.nvim", module = "popup" }

  use {
    "windwp/nvim-spectre",
    opt = true,
    module = "spectre",
    requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
  }

  use {
    "kyazdani42/nvim-tree.lua",
    requires = { "nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
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
    keys = { "<leader><space>", "<leader>fz", "<leader>p" },
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
    keys = "<leader>t",
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
    config = function()
      require("config.neogit")
    end,
  }

  -- Statusline
  use {
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = [[require('config.lualine')]],
    requires = "nvim-web-devicons",
  }

  use {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("config.colorizer")
    end,
  }

  use {
    "folke/trouble.nvim",
    event = "BufReadPre",
    requires = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({ auto_open = false })
    end,
  }

  use { "mbbill/undotree", cmd = "UndotreeToggle" }

  use { "mjlbach/babelfish.nvim", module = "babelfish" }

  use {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.keys")
    end,
  }

  use {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup({})
    end,
  }

  use {
    "RRethy/vim-illuminate",
    event = "CursorHold",
    module = "illuminate",
    config = function()
      vim.g.Illuminate_delay = 1000
    end,
  }

  use "tpope/vim-surround"
  use "christoomey/vim-tmux-navigator" 
  use "seushin/42header.vim"
  use "mhinz/vim-startify"
end)
