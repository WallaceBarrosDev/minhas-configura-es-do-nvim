return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdate", "TSInstall", "TSUninstall" },
  opts = {
    ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "json", "yaml" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}