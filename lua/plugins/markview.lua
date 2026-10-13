return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('markview').setup()

    -- Phím tắt để bật / tắt markdown preview
    vim.keymap.set('n', '<leader>mp', '<cmd>Markview toggle<CR>', { desc = 'Toggle Markview (Buffer)' })
    vim.keymap.set('n', '<leader>mP', '<cmd>Markview Toggle<CR>', { desc = 'Toggle Markview (Global)' })
    vim.keymap.set('n', '<leader>ms', '<cmd>Markview splitToggle<CR>', { desc = 'Toggle Markview Split' })
  end,
}
