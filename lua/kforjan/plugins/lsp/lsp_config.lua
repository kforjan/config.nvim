return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'j-hui/fidget.nvim',
    { "folke/lazydev.nvim", ft = "lua" },
  },

  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup(
        'lsp-attach',
        { clear = true }
      ),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set(
            'n',
            keys,
            func,
            { buffer = event.buf, desc = 'LSP: ' .. desc }
          )
        end

        map(
          'gd',
          require('telescope.builtin').lsp_definitions,
          '[G]oto [D]efinition'
        )
        map(
          'gr',
          require('telescope.builtin').lsp_references,
          '[G]oto [R]eferences'
        )
        map(
          'gI',
          require('telescope.builtin').lsp_implementations,
          '[G]oto [I]mplementation'
        )
        map(
          '<leader>D',
          require('telescope.builtin').lsp_type_definitions,
          'Type [D]efinition'
        )
        map(
          '<leader>ds',
          require('telescope.builtin').lsp_document_symbols,
          '[D]ocument [S]ymbols'
        )
        map(
          '<leader>ws',
          require('telescope.builtin').lsp_dynamic_workspace_symbols,
          '[W]orkspace [S]ymbols'
        )
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>sd', vim.diagnostic.open_float, '[S]how [D]iagnostics')
        map('[d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next [D]iagnostic')
      end,
    })
  end,
}
