-- ~/.config/nvim/lua/configs/keymaps.lua

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- 🧭 Navegação entre buffers
map("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Próximo buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true, desc = "Buffer anterior" })

-- 🪄 Salvar rapidão
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Salvar arquivo" })

-- ❌ Fechar buffer
map("n", "<leader>d", function()
  require("mini.bufremove").delete(0, false)
end, { desc = "Fechar buffer mantendo splits" })

-- 🔄 Recarregar arquivo de configuração atual
map("n", "<leader>s", ":source%<CR>", { noremap = true, silent = true, desc = "Recarregar arquivo atual" })

-- 📋 Copiar para clipboard do sistema
map("v", "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copiar para clipboard" })

-- 🔍 Snacks Picker
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Buscar arquivos" })

map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, { desc = "Buscar texto (grep)" })

map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Listar buffers" })

map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Explorador de arquivos" })

map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Arquivos recentes" })

map("n", "<leader>fd", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnósticos" })

map("n", "<leader>fs", function()
  Snacks.picker.lsp_symbols()
end, { desc = "Símbolos LSP" })

map("n", "<leader>fc", function()
  Snacks.picker.commands()
end, { desc = "Comandos disponíveis" })

-- ✏️ Rename
map("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true, desc = "Renomear símbolo" })

-- 💾 Salvar todos os buffers
map("n", "<leader>wa", "<cmd>wa<CR>", { silent = true, desc = "Salvar todos os buffers" })

-- 🧹 Fechar todos os buffers exceto o atual
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd("bd " .. buf)
    end
  end
end, { desc = "Fechar outros buffers" })

-- 🐞 DAP
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP: Continuar" })

map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "DAP: Step Over" })

map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "DAP: Step Into" })

map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "DAP: Step Out" })

map("n", "<Leader>b", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP: Toggle Breakpoint" })

map("n", "<Leader>dr", function()
  require("dap").repl.open()
end, { desc = "DAP: Abrir REPL" })

-- 📑 Tuxedo
map("n", "<leader>td", "<cmd>lua toggle_tuxedo()<CR>", {
  noremap = true,
  silent = true,
  desc = "Abrir Tuxedo (todo.txt)",
})

-- 🧭 TODO Comments
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Próximo TODO" })

map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "TODO anterior" })

-- 🔧 C/C++ (Makefile / CMake / Auto)
local function has_file(name)
  return vim.fn.filereadable(vim.fn.getcwd() .. "/" .. name) == 1
end

map("n", "<leader>mb", function()
  if has_file("CMakeLists.txt") then
    vim.cmd("!mkdir -p build && cd build && cmake .. && make")
  elseif has_file("Makefile") then
    vim.cmd("!make")
  else
    vim.notify("Nenhum Makefile ou CMakeLists.txt encontrado", vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = "Build: auto-detect (CMake/Make)" })

map("n", "<leader>mr", function()
  if has_file("CMakeLists.txt") then
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.cmd("!./build/" .. project)
  elseif has_file("Makefile") then
    vim.cmd("!make run")
  else
    vim.notify("Nenhum Makefile ou CMakeLists.txt encontrado", vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = "Run: auto-detect" })

map("n", "<leader>mc", function()
  if has_file("Makefile") then
    vim.cmd("!make clean")
  elseif has_file("CMakeLists.txt") then
    vim.cmd("!rm -rf build")
  end
end, { noremap = true, silent = true, desc = "Clean: auto-detect" })

map("n", "<leader>cB", function()
  if has_file("CMakeLists.txt") or has_file("Makefile") then
    vim.cmd("!mkdir -p build && cd build && cmake .. && make")
  else
    local libs = _G.detect_libs and _G.detect_libs() or "-lm"
    vim.cmd("!mkdir -p build && gcc -o build/%:t:r % " .. libs)
  end
end, { noremap = true, silent = true, desc = "C: compilar (auto-detect)" })

map("n", "<leader>cC", function()
  if has_file("CMakeLists.txt") or has_file("Makefile") then
    vim.cmd("!mkdir -p build && cd build && cmake .. && make")
  else
    local libs = _G.detect_libs and _G.detect_libs() or "-lm"
    vim.cmd("!mkdir -p build && g++ -std=c++17 -o build/%:t:r % " .. libs)
  end
end, { noremap = true, silent = true, desc = "C++: compilar (auto-detect)" })

map("n", "<leader>cR", function()
  if has_file("CMakeLists.txt") then
    local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.cmd("!./build/" .. project)
  else
    vim.cmd("!./build/%:t:r")
  end
end, { noremap = true, silent = true, desc = "C/C++: executar binário" })

map("n", "<leader>cT", function()
  local bin
  if has_file("CMakeLists.txt") then
    bin = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  else
    bin = vim.fn.expand("%:t:r")
  end
  local ext = vim.fn.expand("%:e")
  local compiler = ext == "cpp" and "g++ -std=c++17" or "gcc"
  local cmd
  if has_file("CMakeLists.txt") then
    cmd = "!mkdir -p build && cd build && cmake .. && make && echo '✅ Build OK'"
  elseif has_file("Makefile") then
    cmd = "!make && echo '✅ Build OK'"
  else
    local libs = _G.detect_libs and _G.detect_libs() or "-lm"
    cmd = "!mkdir -p build && " .. compiler .. " -o build/" .. bin .. " % " .. libs .. " && echo '✅ Build OK'"
  end
  vim.cmd(cmd)
  if vim.v.shell_error == 0 then
    local run_cmd = has_file("CMakeLists.txt") and "./build/" .. bin or "./build/" .. bin
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({ cmd = run_cmd, direction = "float", close_on_exit = true })
    term:toggle()
  end
end, { noremap = true, silent = true, desc = "C/C++: compilar e rodar no terminal" })

map("n", "<leader>cm", function()
  if has_file("CMakeLists.txt") then
    vim.cmd("!mkdir -p build && cd build && cmake .. && make")
  else
    vim.notify("CMakeLists.txt não encontrado", vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = "CMake: build" })

map("n", "<leader>ct", function()
  local bin
  if has_file("CMakeLists.txt") then
    bin = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  else
    bin = vim.fn.expand("%:t:r")
  end
  local ext = vim.fn.expand("%:e")
  local compiler = ext == "cpp" and "g++ -std=c++17" or "gcc"
  local cmd
  if has_file("CMakeLists.txt") then
    cmd = "!mkdir -p build && cd build && cmake .. && make && echo '✅ Build OK'"
  elseif has_file("Makefile") then
    cmd = "!make && echo '✅ Build OK'"
  else
    local libs = _G.detect_libs and _G.detect_libs() or "-lm"
    cmd = "!mkdir -p build && " .. compiler .. " -o build/" .. bin .. " % " .. libs .. " && echo '✅ Build OK'"
  end
  vim.cmd(cmd)
  if vim.v.shell_error == 0 then
    local run_cmd = has_file("CMakeLists.txt") and "./build/" .. bin or "./build/" .. bin
    local Terminal = require("toggleterm.terminal").Terminal
    local term = Terminal:new({ cmd = run_cmd, direction = "float", close_on_exit = true })
    term:toggle()
  end
end, { noremap = true, silent = true, desc = "C/C++: compilar e rodar no terminal (lowercase)" })

-- 🐍 Python
map("n", "<leader>py", function()
  vim.cmd("!python %")
end, { noremap = true, silent = true, desc = "Python: rodar arquivo" })

map("n", "<leader>pY", function()
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({ cmd = "python " .. vim.fn.expand("%"), direction = "float", close_on_exit = false })
  term:toggle()
end, { noremap = true, silent = true, desc = "Python: rodar no terminal" })

map("n", "<leader>pm", function()
  vim.cmd("!python -m " .. vim.fn.input("Module: "))
end, { noremap = true, silent = true, desc = "Python: rodar módulo" })

map("n", "<leader>pi", function()
  vim.cmd("!pip install -r requirements.txt")
end, { noremap = true, silent = true, desc = "Python: instalar requirements" })

map("n", "<leader>pt", function()
  vim.cmd("!pytest")
end, { noremap = true, silent = true, desc = "Python: rodar testes (pytest)" })

map("n", "<leader>pT", function()
  vim.cmd("!pytest " .. vim.fn.expand("%"))
end, { noremap = true, silent = true, desc = "Python: testar arquivo atual" })

-- ☕ Kotlin
map("n", "<leader>kr", function()
  local file = vim.fn.expand("%")
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("cd " .. dir .. " && kotlinc " .. file .. " -include-runtime -d /tmp/kotlin_out.jar && java -jar /tmp/kotlin_out.jar")
end, { noremap = true, silent = true, desc = "Kotlin: compilar e rodar" })

map("n", "<leader>kR", function()
  local file = vim.fn.expand("%")
  local dir = vim.fn.expand("%:p:h")
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    cmd = "cd " .. dir .. " && kotlinc " .. file .. " -include-runtime -d /tmp/kotlin_out.jar && java -jar /tmp/kotlin_out.jar",
    direction = "float",
    close_on_exit = false
  })
  term:toggle()
end, { noremap = true, silent = true, desc = "Kotlin: rodar no terminal" })

map("n", "<leader>kb", function()
  local cwd = vim.fn.getcwd()
  if vim.fn.filereadable(cwd .. "/gradlew") == 1 then
    vim.cmd("!cd " .. cwd .. " && ./gradlew build")
  elseif vim.fn.filereadable(cwd .. "/mvnw") == 1 then
    vim.cmd("!cd " .. cwd .. " && ./mvnw package")
  elseif vim.fn.filereadable(cwd .. "/build.gradle.kts") == 1 or vim.fn.filereadable(cwd .. "/build.gradle") == 1 then
    vim.cmd("!cd " .. cwd .. " && gradle build")
  elseif vim.fn.filereadable(cwd .. "/pom.xml") == 1 then
    vim.cmd("!cd " .. cwd .. " && mvn package")
  else
    vim.notify("Nenhum build system detectado (gradle/maven)", vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = "Kotlin: build (gradle/maven)" })

map("n", "<leader>kt", function()
  local cwd = vim.fn.getcwd()
  if vim.fn.filereadable(cwd .. "/gradlew") == 1 then
    vim.cmd("!cd " .. cwd .. " && ./gradlew test")
  elseif vim.fn.filereadable(cwd .. "/mvnw") == 1 then
    vim.cmd("!cd " .. cwd .. " && ./mvnw test")
  else
    vim.notify("Nenhum build system detectado para testes", vim.log.levels.WARN)
  end
end, { noremap = true, silent = true, desc = "Kotlin: rodar testes" })

-- 📦 Kotlin LSP (kotlin.nvim)
map("n", "<leader>ko", ":KotlinOrganizeImports<CR>", { noremap = true, silent = true, desc = "Kotlin: organizar imports" })
map("n", "<leader>kf", ":KotlinFormat<CR>", { noremap = true, silent = true, desc = "Kotlin: formatar (IntelliJ)" })
map("n", "<leader>ks", ":KotlinSymbols<CR>", { noremap = true, silent = true, desc = "Kotlin: símbolos do arquivo" })
map("n", "<leader>kS", ":KotlinWorkspaceSymbols<CR>", { noremap = true, silent = true, desc = "Kotlin: símbolos do workspace" })
map("n", "<leader>kR", ":KotlinRename<CR>", { noremap = true, silent = true, desc = "Kotlin: renomear símbolo" })
map("n", "<leader>kr", ":KotlinReferences<CR>", { noremap = true, silent = true, desc = "Kotlin: encontrar referências" })
map("n", "<leader>ka", ":KotlinCodeActions<CR>", { noremap = true, silent = true, desc = "Kotlin: code actions" })
map("n", "<leader>kq", ":KotlinQuickFix<CR>", { noremap = true, silent = true, desc = "Kotlin: quick fix" })
map("n", "<leader>kh", ":KotlinInlayHintsToggle<CR>", { noremap = true, silent = true, desc = "Kotlin: toggle inlay hints" })
map("n", "<leader>kc", ":KotlinCleanWorkspace<CR>", { noremap = true, silent = true, desc = "Kotlin: limpar cache" })
map("n", "<leader>kd", ":KotlinDebug<CR>", { noremap = true, silent = true, desc = "Kotlin: debug attach" })

-- 🐙 Git (Fugitive)
map("n", "<leader>gs", ":G<CR>", { noremap = true, silent = true, desc = "Git: status" })
map("n", "<leader>gc", ":G commit<CR>", { noremap = true, silent = true, desc = "Git: commit" })
map("n", "<leader>gp", ":G push<CR>", { noremap = true, silent = true, desc = "Git: push" })
map("n", "<leader>ga", ":G add %<CR>", { noremap = true, silent = true, desc = "Git: add (stage)" })
map("n", "<leader>gl", ":G log<CR>", { noremap = true, silent = true, desc = "Git: log" })
map("n", "<leader>gd", ":G diff<CR>", { noremap = true, silent = true, desc = "Git: diff" })
map("n", "<leader>gb", ":G blame<CR>", { noremap = true, silent = true, desc = "Git: blame" })
map("x", "<leader>gh", function() require("gitsigns").stage_hunk() end, { desc = "Git: stage hunk selecionado" })

-- 🔷 COBOL
map("n", "<leader>cb", ":!mkdir -p bin && cobc -x % -o bin/%:t:r && echo '--- EXECUTANDO ---' && ./bin/%:t:r<CR>", { noremap = true, silent = true, desc = "COBOL: Compilar e executar" })
map("n", "<leader>cc", ":!mkdir -p bin && cobc -x % -o bin/%:t:r<CR>", { noremap = true, silent = true, desc = "COBOL: Compilar" })
map("n", "<leader>cr", ":!./bin/%:t:r<CR>", { noremap = true, silent = true, desc = "COBOL: Executar" })
map("n", "<leader>ct", ":terminal ./bin/%:t:r<CR>", { noremap = true, silent = true, desc = "COBOL: Executar no terminal" })

-- 🤖 OpenCode

map("n", "<leader>og", function()
  require("opencode").start()
end, { desc = "OpenCode: Abrir/Fechar" })

map("n", "<leader>oa", function()
  require("opencode").ask()
end, { desc = "OpenCode: Perguntar" })

map("n", "<leader>os", function()
  require("opencode").select()
end, { desc = "OpenCode: Selecionar" })

map("n", "<leader>on", function()
  require("opencode").command("session.new")
end, { desc = "OpenCode: Nova sessão" })

map({"n", "x"}, "<C-l>", function()
  require("opencode").ask("@this: ", { submit = true })
end, { desc = "OpenCode: Perguntar sobre buffer atual" })
