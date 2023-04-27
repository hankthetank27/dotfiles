-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Color scheme
  use "savq/melange-nvim"

  -- Treesitter
  use{
      'nvim-treesitter/nvim-treesitter',
      run =  function()
          local ts_update = require('nvim-treesitter.install')
              .update({ with_sync = true })
          ts_update()
      end
  }

  use("nvim-treesitter/playground")

  -- Lightline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Indent lines
  use "lukas-reineke/indent-blankline.nvim"

  -- Vim matchup
  use {
	'andymass/vim-matchup',
	setup = function()
        -- may set any options here
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end
  }

  -- Undotree
  use('mbbill/undotree')

  -- fugitive
  use('tpope/vim-fugitive')

  -- Vim/Tmux navigator
  use "christoomey/vim-tmux-navigator"

  -- file tree
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    use {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        }
      }

  -- Trouble
    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
       require("trouble").setup {
         -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

  -- lsp
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }
  end );
