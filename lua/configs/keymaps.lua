-- ~/.config/nvim/lua/configs/keymaps.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.timeout = true
vim.opt.timeoutlen = 1000

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 🧭 Navegação entre buffers
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)

-- 📂 Abrir netrw (explorer nativo
map('n', '<leader>e', ':Ex<CR>', opts)

-- 🪄 Salvar rapidão
map('n', '<leader>w', ':w<CR>', opts)

-- ❌ Fechar buffer
map('n', '<leader>d', ':bd<CR>', opts)
map('n', '<leader>p', ':bn<CR>', opts)

-- Salvar alterações de buffer
map('n', '<leader>s', ':source%<CR>', opts)


map("v", "<C-c>", '"+y', opts)

-- Alto indentar ao salvar o arquivo

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "normal! gg=G"
})

-- configurações de espaço

vim.opt.tabstop = 2       -- largura de um tab
vim.opt.shiftwidth = 2    -- tamanho da indentação com >>
vim.opt.expandtab = true  -- converte TABs em espaços
vim.opt.smartindent = true -- tenta indentar de forma "inteligente"

-- Linhas relativas

vim.opt.number = true
vim.opt.relativenumber = true

-- Telescope
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
