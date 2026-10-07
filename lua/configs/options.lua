-- ~/.config/nvim/lua/configs/options.lua

vim.opt.timeout = true
vim.opt.timeoutlen = 1000

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.env.EDITOR = "nvim"

vim.g.cobol_legacy_code = true

vim.cmd([[
  augroup cobol_filetype
    autocmd!
    autocmd BufRead,BufNewFile *.cbl,*.cob,*.cpy setfiletype cobol
  augroup END
]])
