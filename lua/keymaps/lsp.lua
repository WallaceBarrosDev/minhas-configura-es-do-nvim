-- Keymaps de LSP e diagnósticos
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Mostrar documentação/diagnóstico da função/linha (hover)
map("n", "K", vim.lsp.buf.hover, opts)

-- Ir para definição e declaração
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
-- Referências: já nativa no Neovim 0.11+ ("grr"); não mapear "gr" sozinho
-- para não quebrar grr/gri/grn/gra

-- Ver detalhes do erro/sugestão na linha atual
map("n", "gl", vim.diagnostic.open_float, opts)
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, wrap = true, float = true })
end, opts)
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, wrap = true, float = true })
end, opts)

-- Ações de código (correções rápidas)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, opts)
-- Renomear variável/função (via LSP, usa clangd em C)
map("n", "<leader>nr", vim.lsp.buf.rename, opts)
