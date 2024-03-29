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

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/57205313dda0ac82ac69e21d5e2a80f3297c14cc/lua/nvim-treesitter/query_predicates.lua#L27
local function valid_args(name, pred, count, strict_count)
  local arg_count = #pred - 1

  if strict_count then
    if arg_count ~= count then
      error(string.format("%s must have exactly %d arguments", name, count))
      return false
    end
  elseif arg_count < count then
    error(string.format("%s must have at least %d arguments", name, count))
    return false
  end

  return true
end

-- custom query predicate for allowing injections based on file extension
local query = require "vim.treesitter.query"

query.add_directive("set-lang-by-filetype!", function (_, _, bufnr, pred, metadata)
    if not valid_args("set-lang-by-filetype!", pred, 2, true) then
        return
    end
    local filename = vim.fn.expand("#"..bufnr..":t")
    local extension_index = filename:find("%.")
    if not extension_index then
        return
    end
    if pred[2] == filename:sub(extension_index + 1) then
        metadata["injection.language"] = pred[3]
    end
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

