return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- Để trống để toggleterm tự động sử dụng shell mặc định (vim.o.shell)
      size = 20,
      open_mapping = [[<c-o>]], -- Phím tắt để mở terminal
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'float', -- 'vertical', 'horizontal', 'tab', 'float'
      close_on_exit = true, -- Khôi phục hành vi mặc định sau khi đã sửa lỗi
    }
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle Terminal' })

    -- Hàm chạy code nhanh (C/C++, Python)
    local function run_code()
      vim.cmd 'write' -- Lưu file trước khi chạy
      local ft = vim.bo.filetype
      local file = vim.fn.expand '%'
      local file_no_ext = vim.fn.expand '%:r'
      local cmd = ''

      if ft == 'cpp' or ft == 'c' then
        -- Compile và Run: g++ file.cpp -o file.exe && ./file.exe
        cmd = string.format('g++ -Wall "%s" -o "%s.exe" && ./"%s.exe"', file, file_no_ext, file_no_ext)
      elseif ft == 'python' then
        cmd = string.format('python3 "%s"', file)
      elseif ft == 'java' then
        -- Nếu có thư mục lib, thêm vào classpath (Windows dùng dấu chấm phẩy ; để ngăn cách)
        if vim.fn.isdirectory 'lib' == 1 then
          cmd = string.format('java -cp ".;lib/*" "%s"', file)
        else
          cmd = string.format('java "%s"', file)
        end
      end

      if cmd ~= '' then
        require('toggleterm').exec(cmd)
      else
        vim.notify('Chưa hỗ trợ chạy loại file này!', vim.log.levels.WARN)
      end
    end

    vim.keymap.set('n', '<leader>r', run_code, { desc = 'Run Code' })
  end,
}
