-- Opções adicionais do Neovim
local opt = vim.opt

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- Mouse
opt.mouse = "a"

-- Tempo de espera p/ CursorHold (erro aparece mais rápido ao parar no cursor)
opt.updatetime = 300

-- Undo
opt.undofile = true
opt.undolevels = 10000