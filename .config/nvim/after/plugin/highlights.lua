local function highlight()
    local hl = vim.api.nvim_set_hl
    hl(0, '@lsp.typemod.type.defaultLibrary', { link = '@type.builtin' })
    hl(0, '@lsp.type.type', { link = '@type' })
    hl(0, '@lsp.type.typeParameter', { link = '@type' })
    hl(0, '@lsp.type.macro', { link = '@constant' })
    hl(0, '@lsp.type.enumMember', { link = '@constant' })
    hl(0, '@event', { link = 'Identifier' })
    hl(0, '@interface', { link = 'Identifier' })
    hl(0, '@modifier', { link = 'Identifier' })
    hl(0, '@decorator', { link = 'Identifier' })
end
-- highlight()
