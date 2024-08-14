-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

-- parser_config.liquid = {
--     install_info = {
--         url = "~/programming_projects/tree-sitter-liquid/", -- local path or git repo
--         files = {
--             "src/parser.c",
--             "src/scanner.c",
--         },
--         -- optional entries:
--         branch = "main", -- default branch in case of git repo if different from master
--         generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--         requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
--     },
--     filetype = "liquid", -- if filetype does not match the parser name
-- }

-- (custom query predicate for allowing injections based on file extension
-- used for liquid (and maybe other template langs?)
require'nvim-treesitter.configs'.setup {

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
    "scss",
    "json",
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

require"vim.treesitter.query".add_directive("set-lang-by-filetype!", function (_, _, bufnr, pred, metadata)
    local filename = vim.fn.expand("#"..bufnr..":t")
    local extension_index = filename:find("%.")
    if not extension_index then
        return
    end
    if pred[2] == filename:sub(extension_index + 1) then
        metadata["injection.language"] = pred[3]
    end
end, true)

local liquid_injections = [[
    ((template_content) @injection.content
     (#set-lang-by-filetype! "liquid" "html")
     (#set-lang-by-filetype! "js.liquid" "javascript")
     (#set-lang-by-filetype! "css.liquid" "css")
     (#set-lang-by-filetype! "scss.liquid" "scss")
     (#set! injection.combined))

     (javascript_statement
      (js_content) @injection.content
      (#set! injection.language "javascript")
      (#set! injection.combined))

    (schema_statement
      (json_content) @injection.content
      (#set! injection.language "json")
      (#set! injection.combined))

    (style_statement
      (style_content) @injection.content
      (#set! injection.language "css")
      (#set! injection.combined))

    ((comment) @injection.content
      (#set! injection.language "comment"))
]]

vim.treesitter.query.set('liquid', 'injections', liquid_injections)

