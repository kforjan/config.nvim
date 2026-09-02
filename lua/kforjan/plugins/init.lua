return {
  'nvim-lua/plenary.nvim',
  'tpope/vim-sleuth',
  {
    'eandrju/cellular-automaton.nvim',
    cmd = 'CellularAutomaton',
    keys = {
      {
        '<leader>flm',
        '<cmd>CellularAutomaton make_it_rain<CR>',
        desc = 'Make it rain',
      },
    },
  },
}
