return {
  'numToStr/Comment.nvim',
  opts = {
    toggler = {
      -- Toggle the current line with <leader>gc (Space g c).
      -- Keep the plugin defaults such as `gc` (operator-pending) and `gcc`.
      line = '<leader>gc',
    },
    pre_hook = function(ctx)
      -- Avoid Comment.nvim's Tree-sitter comment detection for C-family buffers.
      -- Its failure path reports the unhelpful "[Comment.nvim] nil" message.
      if vim.bo.filetype == 'c' or vim.bo.filetype == 'cpp' then
        return ctx.ctype == require('Comment.utils').ctype.blockwise and '/*%s*/' or '//%s'
      end
    end,
  },
  lazy = false,
  config = function(_, opts)
    require('Comment').setup(opts)
  end,
}
