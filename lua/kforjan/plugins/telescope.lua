local data = assert(vim.fn.stdpath 'data') --[[@as string]]
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font,
    },
    {
      'nvim-telescope/telescope-frecency.nvim',
      version = '*',
    },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require 'telescope'.setup {
      defaults = {
        path_display = { 'smart' },
        file_ignore_patterns = { 'node_modules', '%.git$', '%.git%/', '%.venv' },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        current_buffer_fuzzy_find = { sorting_strategy = 'ascending' },
      },
      extensions = {
        fzf = {},
        history = {
          path = vim.fs.joinpath(data, 'telescope_history.sqlite3'),
          limit = 100,
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'frecency')

    local builtin = require 'telescope.builtin'

    vim.keymap.set(
      'n',
      '<leader>fh',
      builtin.help_tags,
      { desc = '[F]ind [H]elp' }
    )
    vim.keymap.set(
      'n',
      '<leader>ff',
      builtin.find_files,
      { desc = '[F]ind [F]iles' }
    )
    vim.keymap.set(
      'n',
      '<leader>fc',
      builtin.grep_string,
      { desc = '[F]ind [C]ursor string in cwd' }
    )
    vim.keymap.set(
      'n',
      '<leader>fg',
      builtin.live_grep,
      { desc = '[F]ind by [G]rep' }
    )
    vim.keymap.set(
      'n',
      '<leader>fd',
      builtin.diagnostics,
      { desc = '[F]ind [D]iagnostics' }
    )
    vim.keymap.set(
      'n',
      '<leader>fb',
      builtin.buffers,
      { desc = '[F]ind [B]uffers' }
    )
    vim.keymap.set(
      'n',
      '<leader>fm',
      builtin.git_status,
      { desc = '[F]ind [M]odified files' }
    )

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
      )
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[F]ind in [N]eovim files' })
  end,
}
