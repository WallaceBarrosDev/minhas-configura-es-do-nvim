-- Kotlin: kotlin.nvim encapsula o kotlin-lsp da JetBrains para o Neovim:
-- completion que insere UMA vez (texto + imports + caret via command do
-- servidor, bug #105 resolvido), inlay hints, intentions/refatorações.
-- IMPORTANTE: o cliente deve ser iniciado pelo kotlin.nvim — por isso o
-- lsp.lua NÃO faz vim.lsp.enable("kotlin_lsp") e o mason-lspconfig o exclui.
return {
  "AlexandrosAlexiou/kotlin.nvim",
  ft = { "kotlin" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "stevearc/oil.nvim",
    "folke/trouble.nvim",
  },
  init = function()
    -- Fallback do binário instalado via AUR (kotlin-lsp-bin):
    -- /usr/share/kotlin/kotlin-lsp/bin/intellij-server. Mason kotlin-lsp
    -- tem prioridade quando presente.
    vim.env.KOTLIN_LSP_DIR = "/usr/share/kotlin/kotlin-lsp"
  end,
  opts = {},
}
