-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  -- Configuração com CoC (Conquer of Completion)
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
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
        "coc-markdownlint",
        "coc-prettier",
        "coc-snippets",
        "coc-solidity",
        -- coc-go removido para usar nvim-lspconfig
      }

      vim.cmd([[
      inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
      nnoremap <silent> K :call CocActionAsync('doHover')<CR>
      ]])

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "cobol", "cbl", "cpy" },
        callback = function()
          vim.b.coc_diagnostic_disable = true
          vim.g.coc_notification_disable = true
        end,
      })
    end,
  },

  -- Mason LSP installer
  {
    "williamboman/mason.nvim",
    priority = 900,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "clangd", "pyright" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Go
      vim.lsp.config("gopls", {})
      vim.lsp.enable("gopls")

      -- C/C++
      vim.lsp.config("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })
      vim.lsp.enable("clangd")

      -- Python
      vim.lsp.config("pyright", {})
      vim.lsp.enable("pyright")
    end,
  },
}

