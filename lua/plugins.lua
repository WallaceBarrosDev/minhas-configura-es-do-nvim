-- ~/.config/nvim/lua/plugins.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Última versão estável
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.lsp"),
  require("plugins.which-key"),
  require("plugins.catppuccin"),
  require("plugins.formatter"),
--  require("plugins.telescope"),
  require("plugins.windsurf"),
  require("plugins.codecompanion"),
  require("plugins.markdown-preview"),
  require("plugins.bufferline"),
  require("plugins.dap"),
  require("plugins.cobol"),
  require("plugins.tuxedo"),
  require("plugins.todo-comments"),
  require("plugins.mole"),
  require("plugins.opencode"),
  require("plugins.snacks"),
  require("plugins.mini-bufremove"),
  require("plugins.discord"),
  require("plugins.wakatime"),
  require("plugins.fugitive"),
  require("plugins.gitsigns"),
})
