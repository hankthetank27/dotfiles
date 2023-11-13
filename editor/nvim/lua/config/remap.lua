vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<Esc>")

-- moves highlighted text
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- cursor stays in place when appending to line above
vim.keymap.set("n", "J", "mzJ`z")

-- centers half screen jump
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- centers search terms
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- pastes buffer without storing highlighted text to buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- edits all instances of word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- etc
vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>")
vim.keymap.set("n", "<leader>pv",  vim.cmd.Ex)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<Leader>rnrw", "<Plug>NetrwRefresh")

