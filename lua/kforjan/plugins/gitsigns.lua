return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame_formatter = ' <author>: <summary> • <author_time>',
    on_attach = function()
      local gitsigns = require('gitsigns')
      vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame)
      vim.keymap.set('n', '<leader>gd', gitsigns.toggle_deleted)
    end
  },
}
