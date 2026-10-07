-- lua/plugins/snacks.lua

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  opts = {
    picker = {
      enabled = true,
    },

    explorer = {
      enabled = true,
    },
  },
}
