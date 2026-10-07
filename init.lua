require("plugins")

require("configs.options")
require("configs.keymaps")
require("configs.timetracker")
require("configs.c-cpp")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
