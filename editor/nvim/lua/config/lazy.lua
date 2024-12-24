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
    -- trouble error diagnostics
    require('lazy_plugins.trouble'),

    --- format on save
    require('lazy_plugins.conform'),

    -- markdown files open in browswer
    require('lazy_plugins.markdown-preview'),

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { {"nvim-lua/plenary.nvim"} }
    },

    require('lazy_plugins.oil'),

    require('lazy_plugins.treesitter'),
    -- being deprecated but still usefull atm
    "nvim-treesitter/playground",

    -- {
    --     "vhyrro/luarocks.nvim",
    --     priority = 1000,
    --     config = true,
    -- },

    {
        "rest-nvim/rest.nvim",
        ft = "http",
        -- dependencies = { "luarocks.nvim" },
        config = function()
            require("rest-nvim").setup()
        end,
    },

    -- status line config
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    -- text alignment by line
    {
        'godlygeek/tabular',
        event = 'VeryLazy',
    },

    -- git
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gs", vim.cmd.Git, desc = "Show git" },
        },
    },

    -- undotree
    {
        "mbbill/undotree",
        lazy = false,
        keys = {
            { "<leader>ut", vim.cmd.UndotreeToggle, desc = "Toggle undotree", },
        },
    },

    -- LSP
    {
        'williamboman/mason.nvim',
        lazy = false,
        opts = {
            PATH = "append"
        },
    },

    require('lazy_plugins.lsp'),

    require('lazy_plugins.autocomplete'),

    -- color scheme
    "savq/melange-nvim",

    -- numbered tabs
    'mkitt/tabline.vim',

    -- surround
    'tpope/vim-surround',

    -- allow plugins to use repeat
    "tpope/vim-repeat",

    -- "f" to two char patterns
    'justinmk/vim-sneak',

    -- auto comment commands
    "tpope/vim-commentary",

    -- vim/tmux navigator
    "christoomey/vim-tmux-navigator",

    -- 'andymass/vim-matchup',
    -- {"sindrets/diffview.nvim", lazy = true},
    --
});
