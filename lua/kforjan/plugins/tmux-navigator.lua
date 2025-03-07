return {
  'christoomey/vim-tmux-navigator',
  config = function()
    local set = vim.keymap.set
    set('n', 'C-h', ':TmuxNavigateLeft<CR>')
    set('n', 'C-j', ':TmuxNavigateDown<CR>')
    set('n', 'C-k', ':TmuxNavigateUp<CR>')
    set('n', 'C-l', ':TmuxNavigateRight<CR>')
  end,
}
