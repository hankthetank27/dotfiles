local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.liquid = {
    install_info = {
        url = "~/programming_projects/tree-sitter-liquid/",
        files = {
            "src/parser.c",
            "src/scanner.c",
        },
        branch = "main",
        generate_requires_npm = false,
        requires_generate_from_grammar = true,
    },
    filetype = "liquid",
}

local query = require "vim.treesitter.query"
query.add_predicate("is-file-extension?", function (_match, _pattern, bufnr, pred)
    if not pred[1] or not pred[2] then
        return
    end

    local filename = vim.api.nvim_buf_get_name(bufnr):match("^.+/(.+)$")

    if not filename then
        return
    end

    local extension_index = filename:find("%.")

    if not extension_index then
        return
    end

    local extension = filename:sub(extension_index)
    return pred[2] == extension
end, true)


require'nvim-treesitter.configs'.setup {

    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "javascript",
        "typescript",
        "rust",
        "python",
        "go",
        "scheme",
        "bash",
        "c",
        "lua",
        "vim",
        "html",
        "css",
        "vimdoc",
        "sql",
        'markdown',
        'liquid',
    },

    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true
    }
}

