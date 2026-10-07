-- lua/plugins/todo-comments.lua

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- 🎨 Estilo visual do destaque
    highlight = {
      multiline = true,                -- Se o comentário detalhado ocupar mais de uma linha, ele destaca o resto também
      keyword = "bg",                  -- Estilo da palavra-chave: "bg" (pinta o fundo), "fg" (pinta só a letra) ou "wide"
      after = "fg",                    -- Como destacar o texto que vem DEPOIS do "TODO:" ("fg", "bg" ou vazio)
      pattern = [[.*<(KEYWORDS)\s*:]], -- Expressão regular que ele busca para ativar o destaque
    },
    
    -- 📋 Lista de palavras-chave customizadas, ícones e cores
    keywords = {
      -- Suas tags padrões mais detalhadas
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ERR" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = "perf", alt = { "OPTIMIZE", "SPEED" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      REVISAR = { icon = " ", color = "review" },
      DONE = { icon = " ", color = "done" },
    },
    
    -- 🌈 Definição exata das cores (Aceita cores hexadecimais puras!)
    colors = {
      error = { "DiagnosticError", "#ErrorMsg", "#DC2626" }, -- Vermelho forte
      warning = { "DiagnosticWarn", "#WarningMsg", "#FBBF24" }, -- Amarelo ouro
      info = { "DiagnosticInfo", "#2563EB" }, -- Azul
      hint = { "DiagnosticHint", "#10B981" }, -- Verde esmeralda
      perf = { "DiagnosticHint", "#7C3AED" }, -- Roxo
      test = { "DiagnosticHint", "#FF007F" }, -- Rosa choque
      review = { "DiagnosticWarn", "#A855F7" }, -- Lilás para revisões
      done = { "DiagnosticHint", "#10B981" },
    },
  },
}
