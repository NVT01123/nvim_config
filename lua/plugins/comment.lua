return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  },
  lazy = false,
  config = function(_, opts)
    require('Comment').setup(opts)
  end,
}