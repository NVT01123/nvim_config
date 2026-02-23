return {
  {
    'lukas-reineke/indent-blankline.nvim',
    name = 'indent_blankline',
    event = { 'BufReadPost', 'BufNewFile' }, -- Đã sửa chữ 'BufNewfile' thành 'BufNewFile' cho đúng chuẩn
    -- Cấu hình exclude của IBL v3 đã thay đổi cấu trúc, bạn cần sửa lại như sau:
    opts = function(_, opts)
      opts.exclude = {
        filetypes = {
          'help',
          'startify',
          'dashboard',
          'packer',
          'neogitstatus',
          'NvimTree',
          'Trouble',
          'alpha',
          'neo-tree',
        },
      }
    end,
    config = function(_, opts)
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      -- DI CHUYỂN PHẦN KHAI BÁO MÀU LÊN TRƯỚC HÀM SETUP
      local hooks = require 'ibl.hooks'
      -- Tạo highlight ngay lập tức thay vì dùng hook (Cách an toàn nhất cho Lazy)
      vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
      vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
      vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
      vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
      vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
      vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
      vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })

      -- Nếu muốn giữ lại cơ chế hook của IBL để đảm bảo màu không bị mất khi đổi colorscheme:
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)

      -- Bây giờ mới gọi setup
      require('ibl').setup {
        indent = { char = '│', highlight = highlight },
        scope = { enabled = false },
        exclude = opts.exclude,
      }
    end,
  },
}
