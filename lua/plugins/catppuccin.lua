return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,       -- carrega na inicialização
    priority = 1000,    -- carrega antes dos outros plugins
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- pode ser "latte", "frappe", "macchiato" ou "mocha"
        transparent_background = true,
        term_colors = true,
        styles = {
          comments = { "italic" },
          functions = { "bold" },
        },
        integrations = {
          treesitter = true,
          cmp = true,
          gitsigns = true,
          -- adicione mais integrações que você usa
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
