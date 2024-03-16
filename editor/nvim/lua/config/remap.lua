vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<Esc>")

-- quick save
vim.keymap.set("n", "<leader>w", ":w<CR>")

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
-- vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>")
-- vim.keymap.set("n", "<leader>pv",  vim.cmd.Ex)
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<Leader>-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "Q", "<nop>")

-- search for all instances currently selected text in buffer
vim.keymap.set("v", "<leader>ls", 'y/\\V<C-R>=escape(@",\'/\')<CR><CR>')

-- set tab nav to numbers
for i = 1, 9 do
    vim.keymap.set("n", string.format("<leader>%d", i), string.format("%dgt", i))
end
vim.keymap.set("n", "<leader>0", ":tablast<cr>")

