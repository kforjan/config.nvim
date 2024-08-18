return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {},
  config = function()
    require('which-key').setup()
    require('which-key').add {
      { '<leader>P', desc = '[P]aste from system clipboard' },
      { '<leader>y', desc = '[Y]ank to system clipboard' },
      { '<leader>Y', desc = '[Y]ank line to system clipboard' },
      { '<leader>p', desc = '[P]aste without affecting clipboard' },
      { '<leader>d', desc = '[D]elete without affecting clipboard' },
      { '<leader>f', group = '[F]ind' },
      { '<leader>F', group = '[F]lutter' },
      { '<leader>,', group = 'Format' },
      { '<leader>t', group = '[T]rouble' },
      { '<leader>g', group = '[G]it' },
    }
  end,
}
