return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    local set = vim.keymap.set

    set('n', '<leader>m', function()
      harpoon:list():add()
    end, { desc = '[M]ark current file with Harpoon' })
    set('n', '<C-m>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    set('n', '<leader>1', function()
      harpoon:list():select(1)
    end)
    set('n', '<leader>2', function()
      harpoon:list():select(2)
    end)
    set('n', '<leader>3', function()
      harpoon:list():select(3)
    end)
    set('n', '<leader>4', function()
      harpoon:list():select(4)
    end)
    set('n', '<leader>5', function()
      harpoon:list():select(5)
    end)
  end,
}
