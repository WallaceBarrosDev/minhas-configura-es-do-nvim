-- lua/plugins/opencode.lua

return {
  "nickjvandyke/opencode.nvim",
  version = "*",

  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {},
        terminal = {},
      },
    },
  },

  config = function()
    vim.o.autoread = true
  end,
}
