return {
  {
    -- View and edit the current buffer as hexadecimal bytes.
    'RaafatTurki/hex.nvim',
    cmd = { 'HexDump', 'HexAssemble', 'HexToggle' },
    keys = {
      { '<leader>bb', '<cmd>HexToggle<CR>', desc = 'Toggle hex view' },
    },
    config = function()
      require('hex').setup()

      -- hex.nvim uses :%!xxd <file>, which makes Neovim pipe the current
      -- buffer to xxd even though xxd is already reading <file>. xxd closes
      -- stdin in that case, resulting in E5677/EPIPE. Use systemlist instead
      -- so xxd reads only the file and its output replaces the buffer.
      local utils = require('hex.utils')
      utils.dump_to_hex = function(dump_cmd)
        local filepath = vim.api.nvim_buf_get_name(0)
        if filepath == '' then
          vim.notify('Cannot show an unnamed buffer as hex', vim.log.levels.WARN)
          return
        end

        local command = vim.list_extend(vim.fn.split(dump_cmd), { filepath })
        local lines = vim.fn.systemlist(command)
        if vim.v.shell_error ~= 0 then
          vim.notify('Failed to create hex view: ' .. table.concat(lines, '\n'), vim.log.levels.ERROR)
          return
        end

        vim.bo.bin = true
        vim.b.hex = true
        vim.b.hex_ft = vim.bo.ft
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
        vim.bo.ft = 'xxd'
        utils.drop_undo_history()
        utils.dettach_all_lsp_clients_from_current_buf()
        vim.bo.mod = false
      end
    end,
  },
}
