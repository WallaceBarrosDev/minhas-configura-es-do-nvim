local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Copiar para clipboard do sistema no modo visual
map("v", "<C-c>", '"+y', opts)

-- Melhor navegação entre janelas
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Navegação entre buffers (Tab / Shift-Tab)
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Deletar buffer atual
map("n", "<leader>bd", ":bdelete<CR>", opts)

-- Limpar destaque de busca
map("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Melhor indentação no modo visual
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Mover linhas para cima/baixo
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Salvar/fechar
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)