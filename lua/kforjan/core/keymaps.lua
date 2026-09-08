local set = vim.keymap.set
local g = vim.g

g.mapleader = ' '
g.maplocalleader = ','

-- visual mode modifications
set('n', 'vv', 'v$')

-- move selected lines
set('x', 'J', ":m '>+1<CR>gv=gv")
set('x', 'K', ":m '<-2<CR>gv=gv")

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
set({ 'n', 'x' }, '<leader>y', [["+y]])
-- paste from system clipboard
set({ 'n', 'x' }, '<leader>P', [["+p]])
-- delete without affecting the current register
set({ 'n', 'x' }, '<leader>d', [["_d]])

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
      vim.notify('This is the last tab, cannot close it!', vim.log.levels.WARN)
    end
  end
end, { noremap = true, silent = true })
set('n', '<leader>%', '<cmd>vsplit<CR>')
set('n', '<leader>"', '<cmd>split<CR>')
