return {
  {
    "folke/which-key.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      spec = {
        { "<leader>f", group = "Files" },
        { "<leader>g", group = "Git" },
      },
    },
  },
}
