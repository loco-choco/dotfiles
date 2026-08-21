require("loco.remap")
print("hello from loco")

vim.filetype.add({
  extension = {
    fst = 'fstar',
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

vim.opt["tabstop"] = 3
vim.opt["shiftwidth"] = 3
