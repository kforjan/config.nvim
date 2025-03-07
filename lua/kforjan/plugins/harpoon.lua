return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    local set = vim.keymap.set

    set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = '[A]dd current file to Harpoon' })
    set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    set('n', '<leader>hh', function()
      harpoon:list():select(1)
    end)
    set('n', '<leader>hj', function()
      harpoon:list():select(2)
    end)
    set('n', '<leader>hk', function()
      harpoon:list():select(3)
    end)
    set('n', '<leader>hl', function()
      harpoon:list():select(4)
    end)
  end,
}
