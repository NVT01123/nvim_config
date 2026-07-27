return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.prettier.with {
          filetypes = {
            'html',
            'javascript',
            'javascriptreact',
            'json',
            'markdown',
            'typescript',
            'typescriptreact',
            'yaml',
          },
          extra_args = { '--tab-width', '4', '--no-use-tabs' },
        },
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt.with { args = { '-i', '4' } },
        require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
        require 'none-ls.formatting.ruff_format',
        null_ls.builtins.formatting.clang_format.with {
          filetypes = { 'c', 'cpp', 'cuda', 'objc', 'objcpp', 'proto' },
          -- Ignore per-project .clang-format indentation settings so every C/C++ buffer uses four spaces.
          extra_args = { '--style={BasedOnStyle: LLVM, IndentWidth: 4, TabWidth: 4, UseTab: Never}' },
        },
      },
      on_attach = function(client, bufnr)
        -- SỬ DỤNG CÁCH KIỂM TRA MỚI AN TOÀN HƠN CHO NEOVIM 0.10+
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                async = false,
                bufnr = bufnr,
                -- Ưu tiên dùng null-ls (none-ls) để tránh đụng độ với các LSP khác (như clangd)
                filter = function(fmt_client)
                  return fmt_client.name == 'null-ls'
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
