-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- Configuração com CoC (Conquer of Completion)
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- Define onde o plugin deve instalar extensões do CoC
      vim.g.coc_global_extensions = {
        "coc-json",
        "coc-tsserver",
        "coc-html",
        "coc-css",
        "coc-pyright",
        "coc-phpls",
        "coc-java",
        "coc-vetur",
        "coc-angular",
        "coc-phpactor",
        "coc-clangd",
        "coc-markdownlint",
        "coc-prettier",
        "coc-snippets",
        -- adicione aqui outras extensões que desejar
      }

      -- Mapeamentos padrão do CoC
      vim.cmd([[
      " Use <Tab> e <S-Tab> para navegar pelas sugestões
      inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

      " Confirmar sugestão com <CR>
      inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
      ]])

      -- Configurações de diagnóstico e hover
      vim.cmd([[
      " Mostrar diagnósticos na linha
      autocmd CursorHold * silent call CocActionAsync('diagnosticRefresh')

      " Habilitar hover
      nnoremap <silent> K :call CocActionAsync('doHover')<CR>
      ]])
    end,
  }
}

