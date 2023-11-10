local powerline = require'lualine.themes.powerline'


require('lualine').setup {
    options = {
        theme  = powerline,
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
    },
}
