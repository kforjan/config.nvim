return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-k>'] = false,
        ['<C-j>'] = false,
      },
      view_options = {
        show_hidden = true,
      },
      watch_for_changes = true,
    }

    local set = vim.keymap.set
    set('n', '\\', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    set('n', '<CMD>Oil<CR>', vim.cmd.Ex)
  end,
}
