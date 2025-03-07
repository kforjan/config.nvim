return {
  'sindrets/diffview.nvim',
  config = function()
    vim.keymap.set('n', '<leader>gg', function()
      if next(require('diffview.lib').views) == nil then
        vim.cmd('DiffviewOpen')
      else
        vim.cmd('DiffviewClose')
      end
    end, { desc = 'Diff' })
    vim.keymap.set(
      'n',
      '<leader>gh',
      '<cmd>:DiffviewFileHistory<cr>',
      { desc = 'History' }
    )
  end,
}
