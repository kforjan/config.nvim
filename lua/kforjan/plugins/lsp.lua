return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    { 'mason-org/mason.nvim', opts = {} },
    { 'mason-org/mason-lspconfig.nvim', opts = { automatic_enable = false } },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'b0o/SchemaStore.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    local servers = {
      bashls = {},
      denols = {
        root_markers = { 'deno.json', 'deno.jsonc' },
        workspace_required = true,
      },
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
        workspace_required = true,
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

        if
          client:supports_method(
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
      end,
    })

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      return type(t) ~= 'table' or not t.manual_install
    end, vim.tbl_keys(servers))

    require('mason-tool-installer').setup {
      ensure_installed = servers_to_install,
    }

    local local_keys = { 'manual_install', 'server_capabilities' }

    for name, settings in pairs(servers) do
      local config = vim.tbl_extend('force', {}, settings)
      for _, key in ipairs(local_keys) do
        config[key] = nil
      end

      config.capabilities =
        require('blink.cmp').get_lsp_capabilities(config.capabilities)

      local overrides = settings.server_capabilities
      if overrides then
        config.on_init = function(client)
          for k, v in pairs(overrides) do
            if v == vim.NIL then
              client.server_capabilities[k] = nil
            else
              client.server_capabilities[k] = v
            end
          end
        end
      end

      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end

    vim.lsp.enable('ruby-lsp')

    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = false,
      severity_sort = true,
    }
  end,
}
