local M = {}

function M.is_windows()
  return vim.loop.os_uname().sysname:match("Windows") ~= nil
end

function M.is_macos()
  return vim.loop.os_uname().sysname == "Darwin"
end

function M.is_linux()
  return vim.loop.os_uname().sysname == "Linux"
end

function M.executable(candidates)
  for _, candidate in ipairs(candidates) do
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
  return candidates[1]
end

return M
