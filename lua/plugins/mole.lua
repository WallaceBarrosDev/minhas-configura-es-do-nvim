-- lua/plugins/mole.lua

return {
  "zion-off/mole.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("mole").setup({
      capture_mode = "snippet",
      auto_open_panel = true,
      virtual_text = true,
      picker = "auto",
      window = { width = 0.3 },
      keys = {
        annotate       = "<leader>ma",
        start_session  = "<leader>ms",
        stop_session   = "<leader>mq",
        resume_session = "<leader>mr",
        toggle_window  = "<leader>mw",
      },
    })
  end,
}
