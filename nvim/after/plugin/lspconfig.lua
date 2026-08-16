require('mini.snippets').setup({})
require('mini.completion').setup({})

vim.lsp.enable({'rust_analyzer', 'csharp_ls', 'fstar'})

vim.lsp.config['fstar'] = {
  cmd - {'fstar.exe', '--ide'}
})
