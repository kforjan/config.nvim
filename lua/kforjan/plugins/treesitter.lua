return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
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
      'ruby',
      'typescript',
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
    },
    additional_vim_regex_highlighting = true,
    indent = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
