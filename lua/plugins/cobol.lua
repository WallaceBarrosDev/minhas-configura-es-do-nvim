-- lua/plugins/cobol.lua

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) ~= "table" then
        opts.ensure_installed = {}
      end
      vim.list_extend(opts.ensure_installed, { "cobol", "c", "cpp", "python", "kotlin" })
    end,
  },
}
