return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/todo-comments.nvim' },
  opts = {
    focus = true,
  },
  cmd = 'Trouble',
  keys = {
    { '<leader>tt', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Open [T]rouble diagnostics' },
    {
      '<leader>tf',
      '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
      desc = 'Open [T]rouble current [F]ile diagnostics',
    },
    { '<leader>tq', '<cmd>Trouble quickfix toggle<CR>', desc = 'Open [T]rouble [Q]uickfix list' },
    { '<leader>tl', '<cmd>Trouble loclist toggle<CR>', desc = 'Open [T]rouble [L]ocation list' },
    { '<leader>td', '<cmd>Trouble todo toggle<CR>', desc = 'Open [T]o[D]os in trouble' },
  },
}
