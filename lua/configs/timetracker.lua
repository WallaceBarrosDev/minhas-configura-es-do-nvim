-- lua/configs/timetracker.lua
-- Local time tracker: logs time spent per project

local data_dir = vim.fn.stdpath("data") .. "/timetracker"
local log_file = data_dir .. "/sessions.json"

local function ensure_dir()
  if vim.fn.isdirectory(data_dir) == 0 then
    vim.fn.mkdir(data_dir, "p")
  end
end

local function load_log()
  ensure_dir()
  if vim.fn.filereadable(log_file) == 1 then
    local ok, data = pcall(vim.fn.json_decode, vim.fn.readfile(log_file))
    if ok and type(data) == "table" then
      return data
    end
  end
  return {}
end

local function save_log(log)
  vim.fn.writefile({ vim.fn.json_encode(log) }, log_file)
end

local function get_project()
  local root = vim.fn.getcwd()
  local name = vim.fn.fnamemodify(root, ":t")
  return name ~= "" and name or "unknown"
end

local current_session = nil

local function start_session()
  if current_session then return end
  current_session = {
    project = get_project(),
    start = os.time(),
  }
end

local function end_session()
  if not current_session then return end
  local elapsed = os.time() - current_session.start
  if elapsed < 5 then
    current_session = nil
    return
  end
  local log = load_log()
  table.insert(log, {
    project   = current_session.project,
    date      = os.date("%Y-%m-%d", current_session.start),
    start_ts  = current_session.start,
    duration  = elapsed,
    start_str = os.date("%H:%M:%S", current_session.start),
    end_str   = os.date("%H:%M:%S"),
  })
  save_log(log)
  current_session = nil
end

-- Report command
vim.api.nvim_create_user_command("TimeReport", function()
  local log = load_log()
  local totals = {}
  for _, entry in ipairs(log) do
    totals[entry.project] = (totals[entry.project] or 0) + entry.duration
  end

  local lines = { "=== Time Report ===" }
  for project, seconds in pairs(totals) do
    local hours = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    table.insert(lines, string.format("%s: %dh %dm", project, hours, mins))
  end
  if #lines == 1 then
    table.insert(lines, "No sessions recorded yet.")
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "TimeTracker" })
end, {})

vim.api.nvim_create_user_command("TimeReportToday", function()
  local log = load_log()
  local today = os.date("%Y-%m-%d")
  local totals = {}
  for _, entry in ipairs(log) do
    if entry.date == today then
      totals[entry.project] = (totals[entry.project] or 0) + entry.duration
    end
  end
  local lines = { "=== Today's Time ===" }
  for project, seconds in pairs(totals) do
    local hours = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    table.insert(lines, string.format("%s: %dh %dm", project, hours, mins))
  end
  if #lines == 1 then
    table.insert(lines, "No sessions today.")
  end
  vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "TimeTracker" })
end, {})

-- Autocommands
local group = vim.api.nvim_create_augroup("TimeTracker", { clear = true })
vim.api.nvim_create_autocmd("VimEnter",      { group = group, callback = start_session })
vim.api.nvim_create_autocmd({ "VimLeavePre", "VimLeave" }, { group = group, callback = end_session })
-- Also save when entering insert mode from normal, to handle crashes
vim.api.nvim_create_autocmd("FocusLost",     { group = group, callback = end_session })
vim.api.nvim_create_autocmd("FocusGained",   { group = group, callback = start_session })
