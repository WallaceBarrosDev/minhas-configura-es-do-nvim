return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "ts_ls", "pyright" },
      -- kotlin_lsp é excluído: quem o inicia é o kotlin.nvim (com o handler
      -- de workspace/configuration que o servidor exige)
      automatic_enable = { exclude = { "kotlin_lsp" } },
    })

    -- Capabilities globais: injeta completions do nvim-cmp em todos os servidores
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    end)
    vim.lsp.config("*", { capabilities = capabilities })

    -- Kotlin: o kotlin.nvim (lua/plugins/kotlin.lua) é quem inicia e
    -- configura o cliente do kotlin-lsp da JetBrains — NÃO habilite
    -- "kotlin_lsp" aqui: um cliente do lspconfig nasce sem o handler de
    -- workspace/configuration e mata inlay hints/settings do plugin.
    -- O fwcd/kotlin_language_server (deprecado) ainda está no mason;
    -- desligado para não disputar o filetype.
    vim.lsp.enable("kotlin_language_server", false)

    -- Como os diagnósticos aparecem (símbolo + mensagem inline + float)
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
    })

    -- Mostra o erro do cursor automaticamente ao ficar parado,
    -- fechando o float quando o cursor sai da linha
    local diag_float_win = nil
    local function close_diag_float()
      if diag_float_win and vim.api.nvim_win_is_valid(diag_float_win) then
        pcall(vim.api.nvim_win_close, diag_float_win, true)
      end
      diag_float_win = nil
    end

    vim.api.nvim_create_autocmd("CursorHold", {
      pattern = "*",
      callback = function()
        -- pcall traz dois valores de open_float: (float_bufnr, winid)
        local ok, _float_bufnr, float_win = pcall(vim.diagnostic.open_float, nil, { focus = false, scope = "line" })
        if ok and float_win then
          diag_float_win = float_win
        else
          close_diag_float()
        end
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      pattern = "*",
      callback = close_diag_float,
    })
  end,
}
