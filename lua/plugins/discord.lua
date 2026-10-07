-- lua/plugins/discord.lua

return {
  "andweeb/presence.nvim",
  config = function()
    require("presence").setup({
      auto_update         = true,
      neovim_image_text   = "Neovim",
      main_image          = "neovim",
      editing_text        = "Neovim",
      file_explorer_text  = "Neovim",
      git_commit_text     = "Neovim",
      plugin_manager_text = "Neovim",
      reading_text        = "Neovim",
      workspace_text      = "%s",
      line_number_text    = "",
    })
  end,
}
