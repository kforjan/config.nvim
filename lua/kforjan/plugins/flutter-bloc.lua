return {
  'kforjan/flutter-bloc.nvim',
  config = function()
    require('flutter-bloc').setup {
      freezed = true,
    }
    vim.keymap.set('n', '<Leader>Fbb', "<cmd>lua require('flutter-bloc').create_bloc()<cr>", { desc = 'Create [B]loc ' })
    vim.keymap.set('n', '<Leader>Fbc', "<cmd>lua require('flutter-bloc').create_cubit()<cr>", { desc = 'Create [C]ubit' })
  end,
}
