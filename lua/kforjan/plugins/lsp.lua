vim.lsp.enable('ruby-lsp')
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'b0o/SchemaStore.nvim',
    'saghen/blink.cmp',
  },
  config = function()
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
      tailwindcss = {},
      templ = {},
      ts_ls = {
        root_markers = { 'package.json' },
        single_file_support = false,
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
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

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(args)
        local client = assert(
          vim.lsp.get_client_by_id(args.data.client_id),
          'must have valid client'
        )

        local function client_supports_method(lsp_client, method, bufnr)
          return lsp_client:supports_method(method, bufnr)
        end

        if
          client
          and client_supports_method(
            client,
            vim.lsp.protocol.Methods.textDocument_documentHighlight,
            args.buf
          )
        then
          local highlight_augroup =
            vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = args.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = args.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds {
                group = 'lsp-highlight',
                buffer = event2.buf,
              }
            end,
          })
        end

        local set = vim.keymap.set
        set('n', '<leader>sd', vim.diagnostic.open_float)
        set('n', '<leader>rn', vim.lsp.buf.rename)
        set('n', '<leader>ca', vim.lsp.buf.code_action)

        local settings = servers[client.name] or {}
        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            client.server_capabilities[k] = (v == vim.NIL) and nil or v
          end
        end
      end,
    })

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      return type(t) ~= 'table' or not t.manual_install
    end, vim.tbl_keys(servers))

    require('mason-tool-installer').setup {
      ensure_installed = servers_to_install,
    }

    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end

      config.capabilities =
        require('blink.cmp').get_lsp_capabilities(config.capabilities)

      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end

    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = false,
      severity_sort = true,
    }
  end,
}
