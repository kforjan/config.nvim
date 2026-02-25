local set = vim.keymap.set
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ','

-- visual mode modifications
set('n', 'vv', 'v$')

-- move selected lines
set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")

-- next line join
set('n', 'J', 'mzJ`z')
-- move half a page
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')
-- improved search view positioning
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')

-- paste without affecting the current register
set('x', '<leader>p', [["_dP]])
-- copy to system clipboard
set({ 'n', 'v' }, '<leader>y', [["+y]])
-- paste from system clipboard
set({ 'n', 'v' }, '<leader>P', [["+p]])
-- delete without affecting the current register
set({ 'n', 'v' }, '<leader>d', [["_d]])

-- start tmux sessionizer (fzf project dirs and create/navigate sessoins)
set('n', '<M-t>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

set('n', '<leader>i', 'i<CR><Esc>ko')
set('n', 'Q', '<nop>')

set('n', '<leader>z', function()
  local win_amount = #vim.api.nvim_tabpage_list_wins(0)
  local tabs = vim.api.nvim_list_tabpages()

  if win_amount > 1 then
    vim.cmd('tab split')
  else
    if #tabs > 1 then
      vim.cmd('tabc')
    else
      print('This is the last tab, cannot close it!')
    end
  end
end, { noremap = true, silent = true })
