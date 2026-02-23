require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
vim.opt.cursorline = true
vim.lsp.set_log_level 'debug'
-- nvim/init.lua (if your color scheme does not already provide these highlight groups)

vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
vim.opt.shell = 'C:\\"Program Files"\\PowerShell\\7\\pwsh.exe'
vim.opt.shellcmdflag = '-NoLogo'

require('lazy').setup {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      vim.keymap.set('n', '<Leader>o', ':NeoTreeFocusToggle<CR>', { desc = 'Toggle NeoTree' })
    end,
  },
  {
    -- Add a custom keybinding to toggle the colorscheme
    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = 'CyberdreamToggleMode',
    --   callback = function(event)
    --     print('Switched to ' .. event.data .. ' mode!')
    --   end,
    -- }),
    vim.api.nvim_set_keymap('n', '<leader>tt', ':CyberdreamToggleMode<CR>', { noremap = true, silent = true }),
  },
  {
    import = 'plugins',
  },
}
