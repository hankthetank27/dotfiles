local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup({
    -- considering...
    -- 'andymass/vim-matchup',
    -- 'godlygeek/tabular',
    --
    --
    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { {"nvim-lua/plenary.nvim"} }
    },

    -- color scheme
    "savq/melange-nvim",

    -- treesitter
     {
        "nvim-treesitter/nvim-treesitter",
        build =  function()
            local ts_update = require('nvim-treesitter.install')
            .update({ with_sync = true })
            ts_update()
        end
    },

    -- status line config
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    -- numbered tabs
    'mkitt/tabline.vim',

    -- markdown files open in browswer
    'instant-markdown/vim-instant-markdown',

    -- surround
    'tpope/vim-surround',

    -- allow plugins to use repeat
    "tpope/vim-repeat",

    -- "f" to two char patterns
    'justinmk/vim-sneak',

    -- auto comment commands
    "tpope/vim-commentary",

    -- git
    "tpope/vim-fugitive",

    -- undotree
    "mbbill/undotree",

    -- vim/tmux navigator
    "christoomey/vim-tmux-navigator",

    -- trouble
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                use_diagnostic_signs = true,
                icons = false
            }
        end
    },

    -- LSP support
    {"VonHeikemen/lsp-zero.nvim", branch = 'v3.x',},
    {"neovim/nvim-lspconfig"},
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},

    -- autocompletion
    {"hrsh7th/nvim-cmp"},
    {"hrsh7th/cmp-buffer"},
    {"hrsh7th/cmp-path"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"hrsh7th/cmp-nvim-lua"},
    {"saadparwaiz1/cmp_luasnip"},
    {"L3MON4D3/LuaSnip"},
    {"rafamadriz/friendly-snippets"},
    {"ray-x/lsp_signature.nvim"},

});