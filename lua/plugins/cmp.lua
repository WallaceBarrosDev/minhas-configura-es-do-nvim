return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    -- Snippets prontos por filetype (html, css, js, ...)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Snippets custom de Kotlin: completions de top-level (println) são
    -- um problema do kotlin-language-server da comunidade; printing garante
    -- o atalho independente do LSP
    local ls = require("luasnip")
    local s, t, i = ls.snippet, ls.text_node, ls.insert_node
    ls.add_snippets("kotlin", {
      s({ trig = "println", dscr = "println(\"...\")" }, {
        t('println("'), i(1), t('")'),
      }),
      s({ trig = "print", dscr = "print(...)" }, {
        t("print("), i(1), t(")"),
      }),
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}