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

        -- Push (capital P)
        vim.keymap.set('n', '<leader>gP', function()
          vim.cmd.Git 'push'
        end, { desc = 'Git [P]ush', buffer = bufnr, remap = false })

        -- Pull with merge
        vim.keymap.set('n', '<leader>gpm', function()
          vim.cmd.Git 'pull'
        end, { desc = 'Git [P]ull ([M]erge)', buffer = bufnr, remap = false })

        -- Pull with rebase
        vim.keymap.set('n', '<leader>gpr', function()
          vim.cmd.Git { 'pull', '--rebase' }
        end, { desc = 'Git [P]ull ([R]ebase)', buffer = bufnr, remap = false })

        -- Merge (specify branch)
        vim.keymap.set('n', '<leader>gm', function()
          vim.cmd ':Git merge '
        end, { desc = 'Git [M]erge (specify branch)', buffer = bufnr, remap = false })

        -- Rebase (specify branch)
        vim.keymap.set('n', '<leader>gr', function()
          vim.cmd ':Git rebase '
        end, { desc = 'Git [R]ebase (specify branch)', buffer = bufnr, remap = false })

        -- Add all changes
        vim.keymap.set('n', '<leader>ga', function()
          vim.cmd.Git 'add .'
        end, { desc = 'Git [A]dd All', buffer = bufnr, remap = false })

        -- Commit with a message
        vim.keymap.set('n', '<leader>gcm', function()
          vim.cmd ':Git commit'
          vim.cmd 'normal! i' -- Place cursor inside quotes for the message
        end, { desc = 'Git [C]o[m]mit', buffer = bufnr, remap = false })

        -- Diff
        vim.keymap.set('n', '<leader>gd', function()
          vim.cmd.Git 'diff'
        end, { desc = 'Git [D]iff', buffer = bufnr, remap = false })

        -- Checkout branch
        vim.keymap.set('n', '<leader>gco', function()
          vim.cmd ':Git checkout '
        end, { desc = 'Git [C]heck[o]ut Branch', buffer = bufnr, remap = false })

        -- Checkout new branch
        vim.keymap.set('n', '<leader>gcb', function()
          vim.cmd ':Git checkout -b '
        end, { desc = 'Git [C]heckout New [B]ranch', buffer = bufnr, remap = false })
      end,
    })

    -- Conflict resolution keymaps
    vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>', { desc = 'Get Changes from Base (//2)' })
    vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>', { desc = 'Get Changes from Other (//3)' })
  end,
}
