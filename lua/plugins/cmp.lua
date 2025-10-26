return {
  -- Engine de completions
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",   -- Conecta LSP → nvim-cmp
      "L3MON4D3/LuaSnip",       -- Snippets engine (opcional, mas recomendado)
      "saadparwaiz1/cmp_luasnip", -- Fonte de snippets para o cmp
    },
    event = "InsertEnter",     -- carrega só quando for usar completion
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]     = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },
}
