return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  config = function()
    local conform = require('conform')
    conform.setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        svelte = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'jq' },
        eruby = { 'erb_format', 'erb-formatter', stop_after_first = true },
      },
    }

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('custom-conform', { clear = true }),
      callback = function(args)
        if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
          return
        end
        require('conform').format {
          bufnr = args.buf,
          lsp_format = 'fallback',
          quiet = false,
        }
      end,
    })

    vim.api.nvim_create_user_command('FormatToggle', function(args)
      if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end
    end, {
      desc = 'Toggle format-on-save (! for this buffer only)',
      bang = true,
    })
  end,
}
