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
      templ = {},
      solargraph = {
        cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
      },
      -- ruby_lsp = {
      --   root_dir = require('lspconfig').util.root_pattern 'Gemfile',
      --   single_file = true,
      --   init_options = {
      --     formatter = 'auto',
      --     experimentalFeatures = true,
      --   },
      -- },
      ts_ls = {
        root_dir = require('lspconfig').util.root_pattern 'package.json',
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

    local lspconfig = require 'lspconfig'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(args)
        local client = assert(
          vim.lsp.get_client_by_id(args.data.client_id),
          'must have valid client'
        )

        local function client_supports_method(client, method, bufnr)
          return client:supports_method(method, bufnr)
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

        local builtin = require 'telescope.builtin'
        local map = function(keys, func, desc)
          vim.keymap.set(
            'n',
            keys,
            func,
            { buffer = 0, desc = 'LSP: ' .. desc }
          )
        end

        map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
        map('gr', builtin.lsp_references, '[G]oto [R]eferences')
        map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
        map(
          '<leader>ws',
          builtin.lsp_dynamic_workspace_symbols,
          '[W]orkspace [S]ymbols'
        )
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('<leader>sd', vim.diagnostic.open_float, '[S]how [D]iagnostics')
        map('[d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next [D]iagnostic')

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
      return type(t) == 'table' and not t.manual_install or t
    end, vim.tbl_keys(servers))

    require('mason-tool-installer').setup {
      ensure_installed = servers_to_install,
    }

    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({
      ensure_installed = {},
      automatic_installation = false,
    })

    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config.capabilities =
        require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[name].setup(config)
    end

    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = true,
      severity_sort = true,
    }
  end,
}
