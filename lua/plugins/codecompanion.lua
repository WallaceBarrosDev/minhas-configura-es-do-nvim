return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        -- Aqui você escolhe o provedor da IA
        http = {
          ollama = {
            endpoint = "http://127.0.0.1:11434", -- padrão do Ollama
            model = "llama3", -- pode trocar para codellama, mistral etc
          },
        },
      },
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
    })
  end,
}
