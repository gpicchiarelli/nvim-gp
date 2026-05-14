local jobs = require("utils.jobs")

local M = {}

local function executable()
  return vim.fn.executable("clips") == 1
end

local function current_file()
  return vim.fn.expand("%:p")
end

local function shell_path(path)
  return path:gsub("\\", "\\\\"):gsub('"', '\\"')
end

local function script(lines)
  local path = vim.fn.tempname() .. ".clp"
  vim.fn.writefile(lines, path)
  return path
end

local function ensure()
  if executable() then
    return true
  end
  vim.notify("CLIPS non trovato nel PATH. Installa il binario `clips` o usa WSL2/Debian.", vim.log.levels.WARN)
  return false
end

function M.console()
  if not ensure() then
    return
  end
  vim.cmd("botright split")
  vim.cmd("terminal clips")
  vim.cmd("startinsert")
end

function M.load_file()
  if not ensure() then
    return
  end
  local file = current_file()
  vim.cmd("botright split")
  vim.cmd('terminal clips -f2 ' .. vim.fn.shellescape(script({
    '(clear)',
    '(load "' .. shell_path(file) .. '")',
    '(facts)',
    '(agenda)',
    '(exit)',
  })))
end

function M.run_file()
  if not ensure() then
    return
  end
  local file = current_file()
  jobs.quickfix({ "clips", "-f2", script({
    '(clear)',
    '(load "' .. shell_path(file) .. '")',
    '(reset)',
    '(run)',
    '(facts)',
    '(exit)',
  }) }, { title = "CLIPS esecuzione" })
end

function M.check_file()
  if not ensure() then
    return
  end
  local file = current_file()
  jobs.quickfix({ "clips", "-f2", script({
    '(clear)',
    '(load "' .. shell_path(file) .. '")',
    '(exit)',
  }) }, { title = "CLIPS check" })
end

function M.reset_run()
  if not ensure() then
    return
  end
  local file = current_file()
  jobs.quickfix({ "clips", "-f2", script({
    '(clear)',
    '(load "' .. shell_path(file) .. '")',
    '(reset)',
    '(run)',
    '(exit)',
  }) }, { title = "CLIPS reset/run" })
end

function M.scratch()
  vim.cmd("vnew")
  vim.bo.filetype = "clips"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "; Sistema esperto CLIPS",
    "",
    "(deftemplate fatto",
    "  (slot nome)",
    "  (slot valore))",
    "",
    "(deffacts stato-iniziale",
    "  (fatto (nome esempio) (valore vero)))",
    "",
    "(defrule regola-esempio",
    "  (fatto (nome esempio) (valore vero))",
    "  =>",
    '  (printout t "Regola attivata" crlf))',
    "",
    "(reset)",
    "(run)",
  })
end

function M.facts()
  if not ensure() then
    return
  end
  jobs.quickfix({ "clips", "-f2", script({
    '(load "' .. shell_path(current_file()) .. '")',
    '(reset)',
    '(facts)',
    '(exit)',
  }) }, { title = "CLIPS facts" })
end

function M.agenda()
  if not ensure() then
    return
  end
  jobs.quickfix({ "clips", "-f2", script({
    '(load "' .. shell_path(current_file()) .. '")',
    '(reset)',
    '(agenda)',
    '(exit)',
  }) }, { title = "CLIPS agenda" })
end

return M
