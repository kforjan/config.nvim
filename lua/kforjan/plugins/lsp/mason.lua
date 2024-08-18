return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- import mason
    local mason = require 'mason'

    -- import mason-lspconfig
    local mason_lspconfig = require 'mason-lspconfig'

    local mason_tool_installer = require 'mason-tool-installer'

    mason.setup()

    mason_lspconfig.setup {
      -- list of servers for mason to install
      ensure_installed = {
        'gopls',
        'tsserver',
        'html',
        'cssls',
        'lua_ls',
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'stylua', -- lua formatter
        'eslint_d',
      },
    }
  end,
}
