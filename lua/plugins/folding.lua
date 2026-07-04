return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  event = 'BufReadPost', -- Chỉ tải khi mở file để tối ưu hiệu suất
  init = function()
    -- Các cấu hình cốt lõi này phải đặt trong init() để chạy trước khi plugin nạp
    vim.o.foldcolumn = '1' -- Hiện cột báo hiệu đóng/mở bên trái
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()
    local ufo = require 'ufo'

    ufo.setup {
      -- Cấu hình cơ chế cốt lõi: Ưu tiên dùng LSP, nếu không có thì dùng Treesitter, cuối cùng dùng Indent
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }

    -- Đặt lại keymap chuẩn xác cho nvim-ufo
    vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Mở tất cả block code' })
    vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Đóng tất cả block code' })

    -- Phím za, zo, zc vẫn giữ nguyên chức năng mặc định của Neovim nhưng sẽ mượt hơn
  end,
}
