return {
  {
    'vim-ruby/vim-ruby',
    ft = 'ruby',
    config = function()
      vim.cmd [[autocmd FileType ruby setlocal indentkeys-=.]]
    end,
  },
  {
    'slim-template/vim-slim',
  },
  {
    'weizheheng/ror.nvim',
    ft = 'ruby',
    config = function()
      local set = vim.keymap.set
      set(
        'n',
        '<leader>Rc',
        "<cmd>lua require('ror.commands').list_commands()<cr>",
        { desc = 'Comands' }
      )
      set(
        'n',
        '<leader>Rf',
        "<cmd>lua require('ror.finders').select_finders()<cr>",
        { desc = 'Finders' }
      )
      set(
        'n',
        '<leader>Rr',
        "<cmd>lua require('ror.routes').list_routes()<cr>",
        { desc = 'List routes' }
      )
      set(
        'n',
        '<leader>Rs',
        "<cmd>lua require('ror.routes').sync_routes()<cr>",
        { desc = 'Sync routes' }
      )
      set(
        'n',
        '<leader>Rt',
        "<cmd>lua require('ror.schema').list_table_columns()<cr>",
        { desc = 'Show tables columns' }
      )
    end,
  },
}
