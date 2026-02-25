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
    current_line_blame_formatter = ' <author>(<author_time>): <summary>',
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')
      local set = vim.keymap.set
      set('n', '<leader>gb', gitsigns.toggle_current_line_blame, {
        desc = 'Blame',
        buffer = bufnr,
      })
      set('n', '<leader>gd', gitsigns.preview_hunk_inline, {
        desc = 'Inline diff',
        buffer = bufnr,
      })
    end,
  },
}
