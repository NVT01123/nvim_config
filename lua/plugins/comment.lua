return {
  'numToStr/Comment.nvim',
  opts = {
    toggler = {
      -- Toggle the current line with <leader>gc (Space g c).
      -- Keep the plugin defaults such as `gc` (operator-pending) and `gcc`.
      line = '<leader>gc',
    },
    pre_hook = function(ctx)
      local filetype = vim.bo.filetype
      if filetype == 'json' then
        error({
          msg = 'JSON does not support comments. Use JSONC if comments are required.',
        })
      end

      -- Return explicit commentstrings for these filetypes instead of relying
      -- on Tree-sitter detection, which can otherwise produce a nil error.
      local commentstrings = {
        c = { line = '//%s', block = '/*%s*/' },
        cpp = { line = '//%s', block = '/*%s*/' },
        java = { line = '//%s', block = '/*%s*/' },
        python = { line = '#%s' },
      }
      local syntax = commentstrings[filetype]
      if syntax then
        local ctype = require('Comment.utils').ctype
        if ctx.ctype == ctype.blockwise then
          if not syntax.block then
            error({
              msg = filetype .. ' does not support block comments.',
            })
          end
          return syntax.block
        end
        return syntax.line
      end
    end,
  },
  lazy = false,
  config = function(_, opts)
    require('Comment').setup(opts)
  end,
}
