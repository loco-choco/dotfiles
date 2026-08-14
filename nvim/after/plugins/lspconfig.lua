require('mini.snippets').setup({})
require('mini.completion').setup({})

vim.lsp.enable({'rust_analyzer', 'fstar'})
