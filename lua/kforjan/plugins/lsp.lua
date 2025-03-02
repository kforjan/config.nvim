return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/lazydev.nvim', ft = 'lua' },
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'stevearc/conform.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'b0o/SchemaStore.nvim',
  },

  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconfig = require 'lspconfig'
    require('lazydev').setup()

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
      solargraph = {},
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

    local servers_to_install = vim.tbl_filter(function(key)
      local t = servers[key]
      if type(t) == 'table' then
        return not t.manual_install
      else
        return t
      end
    end, vim.tbl_keys(servers))

    require('mason').setup()
    require('mason-tool-installer').setup {
      ensure_installed = servers_to_install,
    }

    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end
      config = vim.tbl_deep_extend('force', {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = assert(
          vim.lsp.get_client_by_id(args.data.client_id),
          'must have valid client'
        )

        local settings = servers[client.name]
        if type(settings) ~= 'table' then
          settings = {}
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

        if settings.server_capabilities then
          for k, v in pairs(settings.server_capabilities) do
            if v == vim.NIL then
              ---@diagnostic disable-next-line: cast-local-type
              v = nil
            end

            client.server_capabilities[k] = v
          end
        end
      end,
    })

    -- autoformat
    local conform = require('conform')
    conform.setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier' },
        typescript = { 'prettierd', 'prettier' },
        svelte = { 'prettierd', 'prettier' },
        css = { 'prettierd', 'prettier' },
        html = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier' },
      },
    }

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('custom-conform', { clear = true }),
      callback = function(args)
        require('conform').format {
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        }
      end,
    })

    -- autoformat

    vim.diagnostic.config { virtual_text = true, virtual_lines = true }
  end,
}
