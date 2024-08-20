return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
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

    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fs<leader>',
      ":lua vim.cmd('FlutterRun --' .. vim.fn.input('FlutterRun '))<cr>",
      { noremap = true, silent = true, desc = '[F]lutter [s]tart with custom input' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fsd',
      '<cmd>FlutterRun --flavor=development<cr>',
      { noremap = true, silent = true, desc = '[F]lutter [s]tart with [d]evelopment flavor' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fss',
      '<cmd>FlutterRun --flavor=staging<cr>',
      { noremap = true, silent = true, desc = '[F]lutter [s]tart with [s]taging flavor' }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fsp',
      '<cmd>FlutterRun --flavor=production<cr>',
      { noremap = true, silent = true, desc = '[F]lutter [s]tart with [p]roduction flavor' }
    )
    vim.api.nvim_set_keymap('n', '<leader>Fq', '<cmd>FlutterQuit<cr>', { noremap = true, silent = true, desc = '[f]lutter [q]uit' })
    vim.api.nvim_set_keymap('n', '<leader>Fd', '<cmd>FlutterDevices<cr>', { noremap = true, silent = true, desc = '[f]lutter [d]evices' })
    vim.api.nvim_set_keymap('n', '<leader>Fe', '<cmd>FlutterEmulators<cr>', { noremap = true, silent = true, desc = '[f]lutter [e]mulators' })
    vim.api.nvim_set_keymap('n', '<leader>Fc', '<cmd>FlutterLogClear<cr>', { noremap = true, silent = true, desc = '[f]lutter log [c]lear' })
    vim.api.nvim_set_keymap('n', '<leader>FR', '<cmd>FlutterRestart<cr>', { noremap = true, silent = true, desc = '[f]lutter hot [r]estart' })
    vim.api.nvim_set_keymap('n', '<leader>Fr', '<cmd>FlutterReload<cr>', { noremap = true, silent = true, desc = '[f]lutter hot [r]eload' })
    vim.api.nvim_set_keymap('n', '<leader>Fp', '<cmd>FlutterPubGet<cr>', { noremap = true, silent = true, desc = '[f]lutter [p]ub get' })
    vim.api.nvim_set_keymap('n', '<leader>Ft', '<cmd>FlutterDevTools<cr>', { noremap = true, silent = true, desc = '[f]lutter [t]oggle devtools' })
    vim.api.nvim_set_keymap('n', '<leader>Flr', '<cmd>FlutterLspRestart<cr>', { noremap = true, silent = true, desc = '[f]lutter [l]sp [r]estart' })
    vim.api.nvim_set_keymap('n', '<leader>Fx', '<cmd>!dart format . && dart fix --apply<cr>', { noremap = true, silent = true, desc = '[F]i[x] Dart code' })
    vim.api.nvim_set_keymap(
      'n',
      '<leader>Fg',
      ':lua OpenFlutterBuildRunner()<CR>',
      { noremap = true, silent = true, desc = '[F]lutter [g]enerate code with build_runner' }
    )

    function OpenFlutterBuildRunner()
      local cmd = { 'dart', 'run', 'build_runner', 'build', '--delete-conflicting-outputs' }
      local buf = vim.api.nvim_create_buf(false, true) -- Create a new empty buffer

      -- Open a split window to show the terminal output
      vim.api.nvim_command 'botright split'
      vim.api.nvim_win_set_buf(0, buf)

      -- Start a job and display output in the buffer
      vim.fn.termopen(cmd, {
        on_exit = function()
          print 'Flutter build_runner task completed'
        end,
      })

      -- Optional: You can set the buffer to not be modifiable
      vim.bo[buf].modifiable = false
    end
  end,
}
