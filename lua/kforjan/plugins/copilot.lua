return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',

  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = false,
        auto_trigger = false,
        debounce = 0,
        keymap = {
          accept = false,
          accept_word = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<C-g>',
        },
      },
    }
  end,
}
