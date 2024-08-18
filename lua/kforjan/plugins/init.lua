return {
  'nvim-lua/plenary.nvim',
  'tpope/vim-sleuth',
  {
    'eandrju/cellular-automaton.nvim',
    config = function()
      vim.keymap.set('n', '<leader>flm', '<cmd>CellularAutomaton make_it_rain<CR>')
    end,
  },
}
