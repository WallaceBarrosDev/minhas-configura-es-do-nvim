return {
  -- Preview de Markdown no navegador
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    cmd = { "MarkdownPreview" },
    ft = { "markdown" },
  },

  -- Folding baseado em títulos Markdown
  {
    "preservim/vim-markdown",
    ft = "markdown",
    config = function()
      -- Ativa folding baseado em títulos
      vim.g.vim_markdown_folding_disabled = 0

      -- Foldtext customizado (mostra só o título da seção)
      function _G.FoldText()
        return " ⯈ " .. vim.fn.getline(vim.v.foldstart)
      end
      vim.opt.foldtext = "v:lua.FoldText()"
    end,
  },
}

