return {
  'stevearc/conform.nvim',
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
        eruby = { 'erb_format' },
      },

    }

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('custom-conform', { clear = true }),
      callback = function(args)
        require('conform').format {
          bufnr = args.buf,
          lsp_format = 'fallback',
          quiet = false,
        }
      end,
    });
  end,
}
