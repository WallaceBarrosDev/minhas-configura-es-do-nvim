-- lua/configs/c-cpp.lua
-- Auto-CMake: gera/atualiza CMakeLists.txt automaticamente
-- Auto-detect: detecta libs necessárias a partir dos #includes do código

--- Mapeia headers para as flags de link correspondentes
local LIBRARY_MAP = {
  ["math.h"] = "m",
  ["cmath"] = "m",
  ["pthread.h"] = "pthread",
  ["ncurses.h"] = "ncurses",
  ["ncursesw/ncurses.h"] = "ncursesw",
  ["curl/curl.h"] = "curl",
  ["sqlite3.h"] = "sqlite3",
  ["zlib.h"] = "z",
  ["openssl/ssl.h"] = "ssl",
  ["openssl/crypto.h"] = "crypto",
  ["GL/glut.h"] = "glut",
  ["GL/gl.h"] = "GL",
  ["allegro.h"] = "alleg",
  ["allegro5/allegro.h"] = "allegro-5",
  ["SDL2/SDL.h"] = "SDL2",
  ["SDL2/SDL_mixer.h"] = "SDL2_mixer",
  ["SDL2/SDL_ttf.h"] = "SDL2_ttf",
  ["X11/Xlib.h"] = "X11",
  ["readline/readline.h"] = "readline",
  ["json-c/json.h"] = "json-c",
  ["libxml2/libxml/parser.h"] = "xml2",
  ["gmp.h"] = "gmp",
  ["mpfr.h"] = "mpfr",
  ["gsl/gsl_math.h"] = "gsl",
  ["libavcodec/avcodec.h"] = "avcodec",
  ["libavformat/avformat.h"] = "avformat",
  ["libavutil/avutil.h"] = "avutil",
  ["libswscale/swscale.h"] = "swscale",
  ["png.h"] = "png",
  ["jpeglib.h"] = "jpeg",
  ["tiff.h"] = "tiff",
  ["sqlite3.h"] = "sqlite3",
  ["expat.h"] = "expat",
  ["uuid/uuid.h"] = "uuid",
  ["sys/socket.h"] = "",      -- linkage nativo em linux
  ["netinet/in.h"] = "",
  ["arpa/inet.h"] = "",
  ["netdb.h"] = "",
  ["mqueue.h"] = "rt",
  ["aio.h"] = "rt",
  ["semaphore.h"] = "pthread",
  ["rpc/xdr.h"] = "nsl",
  ["curses.h"] = "ncurses",
  ["sys/statvfs.h"] = "",
  ["ftw.h"] = "",
  ["tcl.h"] = "tcl",
  ["Python.h"] = "python3",
}

--- Detecta as libs necessárias lendo o conteúdo de um buffer ou arquivo
--- @param lines string[]|nil linhas do código; se nil, lê o buffer atual
--- @return string flags de ligação no formato "-lm -lpthread"
local function detect_libs(lines)
  if not lines then
    lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  end

  local seen = {}
  local libs = {}

  for _, line in ipairs(lines) do
    -- captura #include <header> e #include "header"
    for header in line:gmatch('#include%s*[<"]([^>"]+)[">]') do
      local lib = LIBRARY_MAP[header]
      if lib and lib ~= "" and not seen[lib] then
        seen[lib] = true
        table.insert(libs, lib)
      end
    end
  end

  -- monta as flags
  local flags = {}
  for _, lib in ipairs(libs) do
    table.insert(flags, "-l" .. lib)
  end

  return table.concat(flags, " ")
end

-- expõe globalmente para keymaps.lua usar
_G.detect_libs = detect_libs

local function get_project_name()
  local root = vim.fn.getcwd()
  return vim.fn.fnamemodify(root, ":t")
end

local function find_source_files()
  local files = {}
  local src_dir = vim.fn.getcwd() .. "/src"
  if vim.fn.isdirectory(src_dir) == 1 then
    -- Find all .c and .cpp files recursively in src/
    local handle = vim.fn.glob(src_dir .. "/**/*.c", false, true)
    for _, f in ipairs(handle) do
      table.insert(files, f)
    end
    handle = vim.fn.glob(src_dir .. "/**/*.cpp", false, true)
    for _, f in ipairs(handle) do
      table.insert(files, f)
    end
  else
    -- Fallback: find .c/.cpp in project root
    local handle = vim.fn.glob("*.c", false, true)
    for _, f in ipairs(handle) do
      table.insert(files, f)
    end
    handle = vim.fn.glob("*.cpp", false, true)
    for _, f in ipairs(handle) do
      table.insert(files, f)
    end
  end
  -- Sort for deterministic output
  table.sort(files)
  return files
end

--- Lê todas as linhas de uma lista de arquivos e retorna libs únicas detectadas
local function detect_libs_from_files(files)
  local seen = {}
  local libs = {}
  for _, filepath in ipairs(files) do
    local fh = io.open(filepath, "r")
    if fh then
      for line in fh:lines() do
        for header in line:gmatch('#include%s*[<"]([^>"]+)[">]') do
          local lib = LIBRARY_MAP[header]
          if lib and lib ~= "" and not seen[lib] then
            seen[lib] = true
            table.insert(libs, lib)
          end
        end
      end
      fh:close()
    end
  end
  table.sort(libs)
  return libs
end

function _G.generate_cmake()
  local project_name = get_project_name()
  local files = find_source_files()

  if #files == 0 then
    vim.notify("Nenhum arquivo .c/.cpp encontrado em src/", vim.log.levels.WARN)
    return
  end

  -- Build the add_executable lines
  local sources = ""
  for _, f in ipairs(files) do
    sources = sources .. "  " .. f .. "\n"
  end

  -- Detect libs from all source files
  local detected_libs = detect_libs_from_files(files)
  local target_link = ""
  if #detected_libs > 0 then
    local link_flags = {}
    for _, lib in ipairs(detected_libs) do
      table.insert(link_flags, lib)
    end
    target_link = string.format("\ntarget_link_libraries(%s\n  %s)\n",
      project_name, table.concat(link_flags, "\n  "))
  end

  local cmake = string.format([[
cmake_minimum_required(VERSION 3.10)
project(%s)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

add_executable(%s
%s)%s]], project_name, project_name, sources, target_link)

  local f = io.open("CMakeLists.txt", "w")
  if f then
    f:write(cmake)
    f:close()
    if #detected_libs > 0 then
      vim.notify("CMakeLists.txt gerado com " .. #files .. " arquivo(s) — libs: " .. table.concat(detected_libs, ", "), vim.log.levels.INFO)
    else
      vim.notify("CMakeLists.txt gerado com " .. #files .. " arquivo(s)", vim.log.levels.INFO)
    end
  else
    vim.notify("Erro ao criar CMakeLists.txt", vim.log.levels.ERROR)
  end
end

-- Auto-generate CMakeLists.txt when creating new C/C++ files
local group = vim.api.nvim_create_augroup("AutoCMake", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  group = group,
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    -- Delay slightly to ensure file is created
    vim.defer_fn(function()
      local cmake_file = vim.fn.getcwd() .. "/CMakeLists.txt"
      if vim.fn.filereadable(cmake_file) == 1 then
        -- CMakeLists.txt exists, regenerate to include new file
        generate_cmake()
      else
        -- No CMakeLists.txt, generate from scratch
        generate_cmake()
      end
    end, 100)
  end,
})

-- Auto-generate CMakeLists.txt when opening nvim in a project with existing C/C++ files
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    vim.defer_fn(function()
      local cmake_file = vim.fn.getcwd() .. "/CMakeLists.txt"
      if vim.fn.filereadable(cmake_file) ~= 1 then
        local files = find_source_files()
        if #files > 0 then
          generate_cmake()
        end
      end
    end, 200)
  end,
})

-- Also regenerate on BufWritePost if it's a new C/C++ file not yet in CMakeLists.txt
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = { "*.c", "*.cpp" },
  callback = function()
    local cmake_file = vim.fn.getcwd() .. "/CMakeLists.txt"
    if vim.fn.filereadable(cmake_file) == 1 then
      local current_file = vim.fn.expand("%:p")
      local cmake_content = vim.fn.readfile(cmake_file)
      local content_str = table.concat(cmake_content, "\n")
      -- Check if current file is already in CMakeLists.txt
      if not string.find(content_str, vim.fn.expand("%")) then
        generate_cmake()
      end
    end
  end,
})

return {}
