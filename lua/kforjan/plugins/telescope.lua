return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    'folke/todo-comments.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local transform_mod = require('telescope.actions.mt').transform_mod

    local trouble = require 'trouble'
    local trouble_telescope = require 'trouble.sources.telescope'

    local custom_actions = transform_mod {
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle 'quickfix'
      end,
    }

    telescope.setup {
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ['<C-t>'] = trouble_telescope.open,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    local keymap = vim.keymap -- for conciseness

    keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
    keymap.set('n', '<leader>fc', builtin.grep_string, { desc = '[F]ind [C]ursor string in cwd' })
    keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
    keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind [O]ld (recent) Files' })
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = '[F]ind [T]odos' })
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
    keymap.set('n', '<leader>fm', builtin.git_status, { desc = '[F]ind [M]odified files' })
    keymap.set('n', '<C-f>', builtin.git_files)

    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[F]ind in [N]eovim files' })
  end,
}
