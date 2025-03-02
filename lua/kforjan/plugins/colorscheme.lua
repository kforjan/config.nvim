return {
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup({
      variant = 'auto',
      dark_variant = 'main',
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
      groups = {},
      palette = {
        main = {
          foam = '#9AC2A5',
        },
      },
      highlight_groups = {},

      before_highlight = function(_, _, _) end,
    })

    vim.cmd('colorscheme rose-pine')
  end,
}
