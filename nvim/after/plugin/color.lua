vim.o.termguicolors = true
vim.api.nvim_command([[
    augroup ModifyColors
        autocmd colorscheme * :hi normal guibg=#282522
        hi DiagnosticError guifg=Red 
        hi DiagnosticWarn  guifg=DarkOrange
        hi DiagnosticInfo  guifg=Blue
        hi DiagnosticHint  guifg=Green
    augroup END
]])
vim.cmd [[silent! colorscheme melange]]
