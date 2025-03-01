return {
  'akinsho/flutter-tools.nvim',
  lazy = true,
  ft = "dart",
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      fvm = true,
      lsp = {
        color = { enabled = true },
        on_attach = function(client)
          client.server_capabilities.semanticTokensProvider = false -- Disable LSP-provided highlights
        end,
      },
    }

    local function flutter_run_with_flavor()
      vim.ui.input({ prompt = 'Enter flavor: ' }, function(flavor)
        if flavor and flavor ~= '' then
          vim.cmd('FlutterRun --flavor=' .. flavor)
        end
      end)
    end

    vim.keymap.set('n', '<leader>Fs<leader>', '<cmd>FlutterRun<cr>', {
      noremap = true,
      silent = true,
      desc = '[F]lutter [s]tart',
    })
    vim.keymap.set('n', '<leader>Ff', flutter_run_with_flavor, {
      noremap = true,
      silent = true,
      desc = '[F]lutter start with [f]lavor (dynamic input)',
    })
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fq',
      '<cmd>FlutterQuit<cr>',
      { noremap = true, silent = true, desc = '[f]lutter [q]uit' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fc',
      '<cmd>FlutterLogClear<cr>',
      { noremap = true, silent = true, desc = '[f]lutter log [c]lear' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>FR',
      '<cmd>FlutterRestart<cr>',
      { noremap = true, silent = true, desc = '[f]lutter hot [r]estart' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fr',
      '<cmd>FlutterReload<cr>',
      { noremap = true, silent = true, desc = '[f]lutter hot [r]eload' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Flr',
      '<cmd>FlutterLspRestart<cr>',
      { noremap = true, silent = true, desc = '[f]lutter [l]sp [r]estart' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fx',
      '<cmd>!dart format . && dart fix --apply<cr>',
      { noremap = true, silent = true, desc = '[F]i[x] Dart code' }
    )
  end,
}
