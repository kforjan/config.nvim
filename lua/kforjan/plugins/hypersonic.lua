return {
  'tomiis4/Hypersonic.nvim',
  event = 'CmdlineEnter',
  cmd = 'Hypersonic',
  config = function()
    require('hypersonic').setup({})
    vim.keymap.set('x', '<leader>wr', '<cmd>Hypersonic<cr>')
  end,
}
