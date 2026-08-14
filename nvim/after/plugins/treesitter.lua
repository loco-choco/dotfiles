require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site',
}
require('nvim-treesitter').install { "c", "lua", "rust" }

vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
callback = function()
  require('nvim-treesitter.parsers').fstar = {
    install_info = {
      url = 'https://github.com/sei40kr/tree-sitter-fstar',
      revision = 'cdb06d462e0ee727c313f3e07c71bc2d288e0f89',
      queries = 'queries/',
    },
  }
end})

vim.treesitter.language.register('fstar', { 'fst' })

vim.filetype.add({
  extension = {
    fst = 'fstar',
  },
})
