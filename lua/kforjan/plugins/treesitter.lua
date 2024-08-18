return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'vim',
      'vimdoc',
      'dart',
      'go',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'markdown' },
    },
    indent = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    local hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local color = string.format('#%06x', hl.fg or 0xFFFFFF)
    vim.api.nvim_set_hl(0, '@property.dart', { fg = color })
  end,
}
