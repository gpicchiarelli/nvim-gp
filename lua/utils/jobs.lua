local M = {}

local function append_data(lines, data)
  if not data then
    return
  end
  for _, line in ipairs(data) do
    if line ~= "" then
      table.insert(lines, line)
    end
  end
end

function M.quickfix(cmd, opts)
  opts = opts or {}
  local lines = {}
  vim.fn.jobstart(cmd, {
    cwd = opts.cwd,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data) append_data(lines, data) end,
    on_stderr = function(_, data) append_data(lines, data) end,
    on_exit = function(_, code)
      if opts.parser then
        vim.fn.setqflist(opts.parser(lines), "r", { title = opts.title or table.concat(cmd, " ") })
      else
        vim.fn.setqflist({}, "r", { title = opts.title or table.concat(cmd, " "), lines = lines })
      end
      if #lines > 0 then
        vim.cmd.copen()
      end
      local level = code == 0 and vim.log.levels.INFO or vim.log.levels.WARN
      vim.notify((opts.title or cmd[1]) .. " terminato con codice " .. code, level)
    end,
  })
end

function M.notify(cmd, opts)
  opts = opts or {}
  vim.fn.jobstart(cmd, {
    cwd = opts.cwd,
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, code)
      local level = code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
      vim.notify((opts.title or table.concat(cmd, " ")) .. " codice " .. code, level)
    end,
  })
end

return M
