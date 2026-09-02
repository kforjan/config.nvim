local vim_syntax_too = { markdown = true, ruby = true }
local no_ts_indent = { ruby = true }

local ensure_installed = {
  'bash',
  'c',
  'dart',
  'go',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'ruby',
  'typescript',
  'vim',
  'vimdoc',
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  dependencies = {
    'RRethy/nvim-treesitter-endwise',
  },
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    ts.setup()
    ts.install(ensure_installed)

    local function enable(buf, ft, lang)
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      if not pcall(vim.treesitter.start, buf, lang) then
        return
      end
      if not no_ts_indent[ft] then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
      if vim_syntax_too[ft] then
        vim.bo[buf].syntax = 'on'
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup(
        'kforjan-treesitter',
        { clear = true }
      ),
      callback = function(args)
        local ft = args.match
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        if vim.treesitter.language.add(lang) then
          enable(args.buf, ft, lang)
        elseif vim.list_contains(ts.get_available(), lang) then
          ts.install(lang):await(function()
            vim.schedule(function()
              enable(args.buf, ft, lang)
            end)
          end)
        end
      end,
    })
  end,
}
