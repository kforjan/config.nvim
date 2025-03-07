return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  ft = 'dart',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'kforjan/flutter-bloc.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      fvm = true,
      lsp = { enabled = false },
    }

    require('flutter-bloc').setup {
      freezed = true,
    }

    local function flutter_run_with_flavor()
      vim.ui.input({ prompt = 'Enter flavor: ' }, function(flavor)
        if flavor and flavor ~= '' then
          vim.cmd('FlutterRun --flavor=' .. flavor)
        end
      end)
    end

    local set = vim.keymap.set

    set('n', '<leader>Fs<leader>', '<cmd>FlutterRun<cr>', {
      noremap = true,
      silent = true,
      desc = '[F]lutter [s]tart',
    })
    set('n', '<leader>Ff', flutter_run_with_flavor, {
      noremap = true,
      silent = true,
      desc = '[F]lutter start with [f]lavor (dynamic input)',
    })
    set('n', '<leader>Fq', '<cmd>FlutterQuit<cr>', {
      noremap = true,
      silent = true,
      desc = '[f]lutter [q]uit',
    })
    set('n', '<leader>Fc', '<cmd>FlutterLogClear<cr>', {
      noremap = true,
      silent = true,
      desc = '[f]lutter log [c]lear',
    })
    set('n', '<leader>FR', '<cmd>FlutterRestart<cr>', {
      noremap = true,
      silent = true,
      desc = '[f]lutter hot [r]estart',
    })
    set('n', '<leader>Fr', '<cmd>FlutterReload<cr>', {
      noremap = true,
      silent = true,
      desc = '[f]lutter hot [r]eload',
    })
    set('n', '<leader>Flr', '<cmd>FlutterLspRestart<cr>', {
      noremap = true,
      silent = true,
      desc = '[f]lutter [l]sp [r]estart',
    })

    -- Flutter bloc
    set(
      'n',
      '<Leader>Fbb',
      "<cmd>lua require('flutter-bloc').create_bloc()<cr>",
      {
        desc = 'Create [B]loc ',
      }
    )
    set(
      'n',
      '<Leader>Fbc',
      "<cmd>lua require('flutter-bloc').create_cubit()<cr>",
      {
        desc = 'Create [C]ubit',
      }
    )
  end,
}
