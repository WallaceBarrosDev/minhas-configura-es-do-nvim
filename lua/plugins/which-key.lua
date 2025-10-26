-- Exemplo no seu arquivo de plugins, tipo plugins.lua

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",  -- ou "VimEnter", pra carregar quando abrir
    config = function()
      require("which-key").setup({})
    end,
  },
  -- outros plugins...
}
