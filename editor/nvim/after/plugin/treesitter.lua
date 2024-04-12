-- (custom query predicate for allowing injections based on file extension
-- used for liquid (and maybe other template langs?)
-- local query = require "vim.treesitter.query"

-- query.add_directive("set-lang-by-filetype!", function (_, _, bufnr, pred, metadata)
--     local filename = vim.fn.expand("#"..bufnr..":t")
--     local extension_index = filename:find("%.")
--     if not extension_index then
--         return
--     end
--     if pred[2] == filename:sub(extension_index + 1) then
--         metadata["injection.language"] = pred[3]
--     end
-- end, true)

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

