local M = {}
local warned_missing = {}

local function executable_linter(lint, name)
  local linter = lint.linters[name]
  if not linter then
    return true
  end
  local cmd = linter.cmd
  if type(cmd) == "function" then
    local ok, resolved = pcall(cmd)
    if ok then
      cmd = resolved
    end
  end
  if type(cmd) ~= "string" or cmd == "" then
    return true
  end
  local executable = vim.fn.executable(cmd) == 1
  if not executable and not warned_missing[name] then
    warned_missing[name] = true
    vim.notify("linter non trovato: " .. cmd .. " (" .. name .. " disabilitato)", vim.log.levels.WARN)
  end
  return executable
end

local function available_linters(lint, names)
  local available = {}
  for _, name in ipairs(names or {}) do
    if executable_linter(lint, name) then
      table.insert(available, name)
    end
  end
  return available
end

function M.setup()
  local lint = require("lint")
  lint.linters_by_ft = {
    perl = { "perlcritic" },
    markdown = { "markdownlint" },
    yaml = { "yamllint" },
    php = { "php" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    zsh = { "shellcheck" },
  }

  lint.linters.perlcritic = {
    cmd = "perlcritic",
    stdin = false,
    append_fname = true,
    args = { "--severity", "5", "--verbose", "%f:%l:%c:%m\n" },
    stream = "stdout",
    ignore_exitcode = true,
    parser = require("lint.parser").from_pattern(
      "([^:]+):(%d+):(%d+):(.*)",
      { "file", "lnum", "col", "message" },
      { source = "perlcritic", severity = vim.diagnostic.severity.WARN }
    ),
  }

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("NvimGpLint", { clear = true }),
    callback = function()
      local linters = available_linters(lint, lint.linters_by_ft[vim.bo.filetype])
      if #linters > 0 then
        lint.try_lint(linters)
      end
    end,
  })
end

return M
