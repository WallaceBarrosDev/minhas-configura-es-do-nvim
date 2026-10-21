return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    })

    -- Nomes de variáveis com cor própria (char/type/etc continuam
    -- destacados); reaplica ao trocar de colorscheme
    local hl = function()
      vim.api.nvim_set_hl(0, "@variable", { fg = "#e0af68" })
      -- tokens semânticos do LSP (clangd) têm prioridade sobre treesitter
      vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = "#e0af68" })
    end
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = hl,
    })
    hl()

    vim.cmd.colorscheme("tokyonight")
  end,
}