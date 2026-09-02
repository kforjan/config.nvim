return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    {
      '<leader>gg',
      function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd('DiffviewOpen')
        else
          vim.cmd('DiffviewClose')
        end
      end,
      desc = 'Diff',
    },
    { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = 'History' },
  },
}
