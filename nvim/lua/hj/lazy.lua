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
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { {"nvim-lua/plenary.nvim"} }
    },

    -- Color scheme
    "savq/melange-nvim",

    -- Treesitter
     {
        "nvim-treesitter/nvim-treesitter",
        build =  function()
            local ts_update = require('nvim-treesitter.install')
            .update({ with_sync = true })
            ts_update()
        end
    },
    "nvim-treesitter/playground",

    -- Lightline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    -- numbered tabs
    'mkitt/tabline.vim',

    -- instant markdown
    'instant-markdown/vim-instant-markdown',

    -- surround
    'tpope/vim-surround',

    -- repeat
    "tpope/vim-repeat",

    -- sneak
    'justinmk/vim-sneak',

    -- commentary
    "tpope/vim-commentary",

    -- fugitive
    "tpope/vim-fugitive",

    -- Indent lines
    "lukas-reineke/indent-blankline.nvim",

    -- Undotree
    "mbbill/undotree",

    -- Vim/Tmux navigator
    "christoomey/vim-tmux-navigator",

    -- Trouble
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

    -- LSP
    {"VonHeikemen/lsp-zero.nvim", branch = 'v3.x',},

    -- LSP support
    {"neovim/nvim-lspconfig"},
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},

    -- Autocompletion
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
