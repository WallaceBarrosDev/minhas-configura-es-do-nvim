-- lua/plugins/tuxedo.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      float_opts = { border = "curved" },
    })

    local Terminal = require("toggleterm.terminal").Terminal
    
    _G.toggle_tuxedo = function()
      -- Pegamos o caminho da pasta atual do projeto
      local current_dir = vim.fn.getcwd()
      
      local tuxedo_tui = Terminal:new({
        cmd = "tuxedo",
        dir = current_dir,
        -- 🔥 Usamos as variáveis de ambiente do próprio Tuxedo para forçar a pasta certa
        env = {
          TUXEDO_TODO_FILE = current_dir .. "/todo.txt",
          TUXEDO_DONE_FILE = current_dir .. "/done.txt",
        },
        hidden = true,
        direction = "float",
        close_on_exit = true,
      })
      
      tuxedo_tui:toggle()
    end
  end,
}
