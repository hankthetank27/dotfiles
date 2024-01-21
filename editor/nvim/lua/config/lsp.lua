local lsp = require('lsp-zero').preset({
    float_border = 'none',
})
local cmp = require('cmp')


lsp.on_attach(function(client, bufnr)

    local opts = {buffer = bufnr, remap = false}

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- lsp mappings
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ee", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    -- disable semantic tokens
    client.server_capabilities.semanticTokensProvider = nil
end)


-- LSPs / LSP manager
require("mason").setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'html',
        'tsserver',
        'rust_analyzer',
        'gopls',
        'theme_check',
    },
    handlers = {
        lsp.default_setup,

        -- lua
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,

        -- ts/js
        tsserver = function ()
            local ts_opts = {
                settings = {
                    completions = {
                        completeFunctionCalls = true
                    }
                }
            }
            require('lspconfig').tsserver.setup(ts_opts)
        end,

        -- rust
        rust_analyzer = function ()
            local rust_opts = {
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                    }
                }
            }
            require('lspconfig').rust_analyzer.setup(rust_opts)
        end,

        -- shopify liquid
        theme_check = function ()
            require('lspconfig').theme_check.setup{}
        end,
    }
})

lsp.set_sign_icons({
    sign_icons = {
        error  = 'E',
        warn   = 'W',
        hint   = 'H',
        info   = 'I'
    }
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    -- can be slightly annoying..
    update_in_insert = true,
    severity_sort = true,

})

-- snippets etc
-- require('luasnip.loaders.from_vscode').lazy_load()
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp_mappings = {
    ['<C-k>'] = cmp.mapping(
        function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
        , { 'i', 'c' }),
    ['<C-j>'] = cmp.mapping(
        function (fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end
        , { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping(
        function (fallback)
            if cmp.visible() then
                cmp.abort()
            else
                fallback()
            end
        end
        , { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(
        function (fallback)
            if cmp.visible() then
                cmp.scroll_docs(-4)
            else
                fallback()
            end
        end
        , { 'i' }),
    ['<C-f>'] = cmp.mapping(
        function (fallback)
            if cmp.visible() then
                cmp.scroll_docs(4)
            else
                fallback()
            end
        end
        , { 'i' }),
    ['<CR>'] = cmp.mapping(
        function (fallback)
            if cmp.visible() then
                cmp.confirm({ select = true})
            else
                fallback()
            end
        end
        , { 'i' }),
    ['<C-y>'] = cmp.mapping(
        function (fallback)
            if cmp.visible() then
                cmp.confirm({ select = true})
            else
                fallback()
            end
        end
        , { 'i','c' }),
    -- toggle cmp menu in command mode
    -- autocompletes to first option if only one exists
    ['<Tab>'] = cmp.mapping(
        function ()
            if cmp.visible() then
                cmp.close()
            else
                cmp.complete()
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = false })
                end
            end
        end
        , { 'c' })
}

cmp.setup({
    -- shows completion sources in menu
    formatting = lsp.cmp_format(),
    -- select first completion option regardless of LSP preselect item
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    sources = {
        -- ordering sets priortiy!!
        {name = 'nvim_lsp'},
        {name = 'path'},

        -- optional below...
        {name = 'buffer', keyword_length = 3},
        -- {name = 'luasnip', keyword_length = 2},
    },
    mapping = cmp_mappings,
    experimental = {
        ghost_text = true,
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp_mappings,
    -- only display menu when toggled on
    completion = {
        autocomplete = false,
    },
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        }),
})

cmp.setup.cmdline('/', {
    mapping = cmp_mappings,
    sources = cmp.config.sources({
        { name = 'buffer' },
    }),
})


-- function signature hints
require "lsp_signature".setup({
    handler_opts = {
        border = "none"
    },
    doc_lines = 0,
    toggle_key = '<C-h>',
})
