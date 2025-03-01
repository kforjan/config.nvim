vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- next line join
vim.keymap.set('n', 'J', 'mzJ`z')
-- move half a page
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- improved search view positioning
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- paste without affecting the current register
vim.keymap.set('x', '<leader>p', [["_dP]])
-- copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
-- paste from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+p]])
-- delete without affecting the current register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- start tmux sessionizer (fzf project dirs and create/navigate sessoins)
vim.keymap.set('n', '<M-t>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

vim.keymap.set('n', '<leader>i', 'i<CR><Esc>ko')
vim.keymap.set('n', 'Q', '<nop>')
