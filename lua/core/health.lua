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

local optional_bins = {
  "clips",
}

local function clips_xs_module()
  return vim.g.nvim_gp_clips_xs_module or vim.env.NVIM_GP_CLIPS_XS_MODULE or "CLIPS"
end

local function perl_module_available(module)
  vim.fn.system({ "perl", "-M" .. module, "-e", "1" })
  return vim.v.shell_error == 0
end

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
  local optional_missing = {}
  for _, bin in ipairs(optional_bins) do
    if vim.fn.executable(bin) == 0 then
      table.insert(optional_missing, bin)
    end
  end
  local xs_module = clips_xs_module()
  if vim.fn.executable("perl") == 1 and not perl_module_available(xs_module) then
    table.insert(optional_missing, "Perl XS " .. xs_module)
  end
  if #missing == 0 then
    local suffix = #optional_missing > 0 and (" Opzionali mancanti: " .. table.concat(optional_missing, ", ")) or ""
    vim.notify("Ambiente Neovim UNIX: tutti gli strumenti principali sono disponibili." .. suffix, vim.log.levels.INFO)
    return
  end
  vim.notify("Strumenti mancanti: " .. table.concat(missing, ", "), vim.log.levels.WARN)
end

return M
