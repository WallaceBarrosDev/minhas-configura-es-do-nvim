local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

wk.setup({
  plugins = {
    marks = true,      -- mostra marks
    registers = true,  -- mostra registers
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  window = {
    border = "rounded",   -- borda arredondada
    position = "cursor",  -- popup perto do cursor (não centralizado)
    margin = {1, 0, 1, 0},
    padding = {1, 1, 1, 1},
    winblend = 0,         -- transparência, 0 = sem transparência
  },
  layout = {
    spacing = 5,          -- espaço entre colunas
  },
  triggers = "auto",      -- ativa automaticamente no <leader> e prefixos
  show_help = false,      -- não mostra ajuda extra
})

-- Registro dos grupos no formato novo
wk.register({
  { "<leader>b", group = "Buffers" },
  { "<leader>f", group = "Files" },
  { "<leader>g", group = "Git" },
})

