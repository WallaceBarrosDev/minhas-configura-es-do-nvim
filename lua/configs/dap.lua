-- ~/.config/nvim/lua/configs/dap.lua

local dap = require("dap")

dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
  options = {
    initialize_timeout_sec = 20,
  },
}

-- Python uses debugpy
dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

-- C configuration
dap.configurations.c = {
  {
    name = "Launch (Makefile)",
    type = "codelldb",
    request = "launch",
    program = function()
      local root = vim.fs.dirname(vim.fs.find("Makefile", { upward = true })[1])
      if root then
        vim.fn.jobstart("make -C " .. root, {
          on_exit = function(_, exit_code)
            if exit_code ~= 0 then
              vim.notify("Build falhou (exit " .. exit_code .. ")", vim.log.levels.ERROR)
            end
          end,
        })
        return root .. "/build/game"
      end
      return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/game", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Launch (CMake)",
    type = "codelldb",
    request = "launch",
    program = function()
      local build_dir = vim.fn.getcwd() .. "/build"
      vim.fn.jobstart("cmake --build " .. build_dir, {
        on_exit = function(_, exit_code)
          if exit_code ~= 0 then
            vim.notify("CMake build falhou (exit " .. exit_code .. ")", vim.log.levels.ERROR)
          end
        end,
      })
      return vim.fn.input("Executable: ", build_dir .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
  {
    name = "Launch (Manual)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- C++ uses the same configs
dap.configurations.cpp = dap.configurations.c

-- Python configuration
dap.configurations.python = {
  {
    name = "Launch file",
    type = "python",
    request = "launch",
    program = "${file}",
    pythonPath = function()
      return vim.fn.exepath("python")
    end,
  },
  {
    name = "Launch file with args",
    type = "python",
    request = "launch",
    program = "${file}",
    args = function()
      local args_str = vim.fn.input("Arguments: ")
      return vim.split(args_str, " ")
    end,
    pythonPath = function()
      return vim.fn.exepath("python")
    end,
  },
  {
    name = "Launch module",
    type = "python",
    request = "launch",
    module = function()
      return vim.fn.input("Module name: ")
    end,
    pythonPath = function()
      return vim.fn.exepath("python")
    end,
  },
}

-- Attach DAP UI listeners are in plugins/dap.lua
