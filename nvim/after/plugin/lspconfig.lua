require('mini.snippets').setup({})
require('mini.completion').setup({})

vim.lsp.enable({'rust_analyzer', 'csharp_ls', 'fstar'})

vim.lsp.config['fstar'] = {
  -- cmd = {'fstar.exe', '--ide'},
  cmd = {'/home/locochoco/projects/fstar-lsp-wrapper/fstar-lsp/target/debug/fstar-lsp'},
}

vim.lsp.set_log_level(vim.log.levels.INFO)
