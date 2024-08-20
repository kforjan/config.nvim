return {
  'tpope/vim-fugitive',
  config = function()
    -- Keymaps for Git status and basic commands
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Status' })

    local kforjan_fugitive = vim.api.nvim_create_augroup('kforjan_fugitive', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = kforjan_fugitive,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        local function map(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
        end

        map('<leader>gP', function()
          vim.cmd.Git 'push'
        end, 'Git [P]ush')

        map('<leader>gpm', function()
          vim.cmd.Git 'pull'
        end, 'Git [P]ull ([M]erge)')

        map('<leader>gpr', function()
          vim.cmd.Git { 'pull', '--rebase' }
        end, 'Git [P]ull ([R]ebase)')

        map('<leader>ga', function()
          vim.cmd.Git 'add .'
        end, 'Git [A]dd All')

        map('<leader>gc', function()
          vim.cmd.Git 'commit'
        end, 'Git [C]ommit')

        map('<leader>gd', function()
          vim.cmd.Git 'diff'
        end, 'Git [D]iff')
      end,
    })

    -- Conflict resolution keymaps
    vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>', { desc = 'Get Changes from Base (//2)' })
    vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>', { desc = 'Get Changes from Other (//3)' })
  end,
}
