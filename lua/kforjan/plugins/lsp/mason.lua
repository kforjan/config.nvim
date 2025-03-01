return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'b0o/SchemaStore.nvim'
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local servers = {
      bashls = {},
      gopls = {
        manual_install = true,
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
          },
        },
      },
      lua_ls = {
        server_capabilities = {
          semanticTokensProvider = vim.NIL,
        },
      },
      rust_analyzer = {},
      svelte = {},
      templ = {},
      ruby_lsp = {
        root_dir = require("lspconfig").util.root_pattern "Gemfile",
        single_file = true,
        init_options = {
          formatter = 'auto',
        },
      },
      ts_ls = {
        root_dir = require("lspconfig").util.root_pattern "package.json",
        single_file = false,
        server_capabilities = {
          documentFormattingProvider = false,
        },
      },
      jsonls = {
        server_capabilities = {
          documentFormattingProvider = false,
        },
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = '',
            },
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})

    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            capabilities,
            server.capabilities or {}
          )
          require('lspconfig')[server_name].setup(server)
        end,
        ['lua_ls'] = function()
          local lspconfig = require 'lspconfig'
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = {
                    'bit',
                    'vim',
                    'it',
                    'describe',
                    'before_each',
                    'after_each',
                  },
                },
              },
            },
          }
        end,
        ['ruby_lsp'] = function()
          local lspconfig = require 'lspconfig'
          lspconfig.ruby_lsp.setup {
            cmd = { 'ruby-lsp' },
            filetypes = { 'ruby', 'eruby' },
            root_dir = lspconfig.util.root_pattern('Gemfile', '.git'),
            init_options = {
              formatter = 'auto',
            },
            single_file_support = true,
          }
        end,
      },
    }
  end,
}
