return {
  'yetone/avante.nvim',
  build = 'make',
  event = 'VeryLazy',
  version = false,
  opts = {
    instructions_file = 'avante.md',
    provider = 'ollama',
    providers = {
      ollama = {
        endpoint = 'http://localhost:11434',
        model = 'gemma4:cloud',
        timeout = 120000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
        -- Desabilita tool calling para modelos que não suportam bem
        disable_tools = true,
      },
    },
    file_selector = {
      provider = 'telescope',
    },
    auto_suggestions = true,
    behaviour = {
      auto_suggest = true,
      jump_result = true,
    },
    -- Desabilita tools globalmente também
    disabled_tools = { 'read_file', 'write_file', 'edit_file', 'delete_file', 'list_files', 'glob', 'grep' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
    'ColinKennedy/mega.cmdparse',
    'ColinKennedy/mega.logging',
  },
}