return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
    highlight = {
      pattern = {
        [[.*<(KEYWORDS)\s*:]],
        [[.*<(KEYWORDS)\([^)]+\)\s*:]],
      },
      keyword = 'bg',
    },
    colors = {
      info = { '#91c3cc' },
    },
  },
}
