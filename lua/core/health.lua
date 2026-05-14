local M = {}
local system = require("utils.system")

local common_bins = {
  "nvim",
  "git",
  "rg",
  "perl",
  "perlcritic",
  "perltidy",
  "prove",
  "carton",
  "cpanm",
  "podchecker",
  "psql",
  "clangd",
}

local platform_bins = {
  macos = { "port", "tmux", "fd", "lldb" },
  linux = { "tmux", "lldb-vscode" },
  windows = { "pwsh", "fd", "lldb-vscode" },
}

function M.required_bins()
  local bins = vim.deepcopy(common_bins)
  local extra = platform_bins.linux
  if system.is_macos() then
    extra = platform_bins.macos
  elseif system.is_windows() then
    extra = platform_bins.windows
  end
  vim.list_extend(bins, extra)
  if system.is_linux() then
    table.insert(bins, vim.fn.executable("fd") == 1 and "fd" or "fdfind")
  end
  return bins
end

function M.missing_bins()
  local missing = {}
  for _, bin in ipairs(M.required_bins()) do
    if vim.fn.executable(bin) == 0 then
      table.insert(missing, bin)
    end
  end
  return missing
end

function M.report()
  local missing = M.missing_bins()
  if #missing == 0 then
    vim.notify("Ambiente Neovim UNIX: tutti gli strumenti principali sono disponibili.", vim.log.levels.INFO)
    return
  end
  vim.notify("Strumenti mancanti: " .. table.concat(missing, ", "), vim.log.levels.WARN)
end

return M
