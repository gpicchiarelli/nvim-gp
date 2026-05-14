local system = require("utils.system")

local M = {}
local cache = { at = 0, data = nil }
local ttl_ms = 5000

local function first_line(cmd)
  local out = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 or not out or not out[1] then
    return ""
  end
  return vim.trim(out[1])
end

local function read_number(path)
  local ok, lines = pcall(vim.fn.readfile, path, "", 1)
  if not ok or not lines[1] then
    return nil
  end
  return tonumber((lines[1]:match("^(%S+)")))
end

local function human_bytes(bytes)
  if not bytes then
    return "n/d"
  end
  local units = { "B", "KiB", "MiB", "GiB", "TiB" }
  local value = bytes
  local idx = 1
  while value >= 1024 and idx < #units do
    value = value / 1024
    idx = idx + 1
  end
  return string.format("%.1f %s", value, units[idx])
end

local function mac_memory()
  local total = tonumber(first_line({ "sysctl", "-n", "hw.memsize" }))
  local page_size = tonumber(first_line({ "pagesize" })) or 4096
  local vm = vim.fn.systemlist({ "vm_stat" })
  local free_pages, speculative_pages, inactive_pages = 0, 0, 0
  for _, line in ipairs(vm) do
    local key, value = line:match("^([^:]+):%s+([%d%.]+)")
    value = tonumber(value)
    if key == "Pages free" then
      free_pages = value or 0
    elseif key == "Pages speculative" then
      speculative_pages = value or 0
    elseif key == "Pages inactive" then
      inactive_pages = value or 0
    end
  end
  local available = (free_pages + speculative_pages + inactive_pages) * page_size
  local used = total and math.max(total - available, 0) or nil
  return total, used
end

local function linux_memory()
  local lines = vim.fn.readfile("/proc/meminfo")
  local values = {}
  for _, line in ipairs(lines) do
    local key, value = line:match("^(%S+):%s+(%d+)")
    if key then
      values[key] = tonumber(value) * 1024
    end
  end
  local total = values.MemTotal
  local available = values.MemAvailable
  local used = total and available and (total - available) or nil
  return total, used
end

local function windows_memory()
  local total = tonumber(first_line({ "powershell", "-NoProfile", "-Command", "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory" }))
  local free_kb = tonumber(first_line({ "powershell", "-NoProfile", "-Command", "(Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory" }))
  local used = total and free_kb and (total - (free_kb * 1024)) or nil
  return total, used
end

local function memory()
  if system.is_macos() then
    return mac_memory()
  elseif system.is_linux() then
    return linux_memory()
  elseif system.is_windows() then
    return windows_memory()
  end
  return nil, nil
end

local function ip_address()
  if system.is_macos() then
    local ip = first_line({ "ipconfig", "getifaddr", "en0" })
    if ip ~= "" then
      return ip
    end
    return first_line({ "ipconfig", "getifaddr", "en1" })
  elseif system.is_linux() then
    local ip = first_line({ "hostname", "-I" })
    return vim.split(ip, "%s+")[1] or ""
  elseif system.is_windows() then
    return first_line({ "powershell", "-NoProfile", "-Command", "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1'} | Select-Object -First 1 -ExpandProperty IPAddress)" })
  end
  return ""
end

local function load_average()
  local avg = vim.loop.getloadavg and vim.loop.getloadavg()
  if avg and avg[1] and avg[1] >= 0 then
    return string.format("%.2f", avg[1])
  end
  if system.is_macos() then
    local raw = first_line({ "sysctl", "-n", "vm.loadavg" })
    return raw:match("{%s*(%S+)") or "n/d"
  end
  if system.is_linux() then
    local raw = vim.fn.readfile("/proc/loadavg", "", 1)[1] or ""
    return raw:match("^(%S+)") or "n/d"
  end
  return "n/d"
end

local function uptime()
  if system.is_macos() then
    local boot = tonumber(first_line({ "sysctl", "-n", "kern.boottime" }):match("sec = (%d+)"))
    if boot then
      return os.time() - boot
    end
  elseif system.is_linux() then
    local seconds = read_number("/proc/uptime")
    return seconds and math.floor(seconds) or nil
  elseif system.is_windows() then
    local seconds = tonumber(first_line({ "powershell", "-NoProfile", "-Command", "[int]((Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime).TotalSeconds" }))
    return seconds
  end
  return nil
end

local function human_duration(seconds)
  if not seconds then
    return "n/d"
  end
  local days = math.floor(seconds / 86400)
  local hours = math.floor((seconds % 86400) / 3600)
  local minutes = math.floor((seconds % 3600) / 60)
  if days > 0 then
    return string.format("%dg %02dh", days, hours)
  end
  return string.format("%02dh %02dm", hours, minutes)
end

local function hostname(uname)
  if uname.nodename and uname.nodename ~= "" then
    return uname.nodename
  end
  if vim.loop.os_gethostname then
    local ok, host = pcall(vim.loop.os_gethostname)
    if ok and host and host ~= "" then
      return host
    end
  end
  local host = first_line({ "hostname" })
  return host ~= "" and host or "host"
end

function M.snapshot()
  local now = vim.loop.now()
  if cache.data and now - cache.at < ttl_ms then
    return cache.data
  end

  local uname = vim.loop.os_uname()
  local total, used = memory()
  local mem_pct = total and used and total > 0 and math.floor((used / total) * 100 + 0.5) or nil
  local data = {
    host = hostname(uname),
    os = uname.sysname or "OS",
    arch = uname.machine or "",
    load = load_average(),
    ram = mem_pct and (mem_pct .. "%") or "n/d",
    ram_full = human_bytes(used) .. " / " .. human_bytes(total),
    ip = ip_address(),
    uptime = human_duration(uptime()),
  }

  cache = { at = now, data = data }
  return data
end

function M.status_cpu()
  return "CPU " .. M.snapshot().load
end

function M.status_ram()
  return "RAM " .. M.snapshot().ram
end

function M.status_net()
  local ip = M.snapshot().ip
  if ip == "" then
    return "NET n/d"
  end
  return "NET " .. ip
end

function M.lines()
  local data = M.snapshot()
  return {
    "Sistema",
    "  Host:    " .. data.host,
    "  OS:      " .. data.os .. " " .. data.arch,
    "  Uptime:  " .. data.uptime,
    "  CPU:     load " .. data.load,
    "  RAM:     " .. data.ram_full .. " (" .. data.ram .. ")",
    "  Rete:    " .. (data.ip ~= "" and data.ip or "non disponibile"),
  }
end

function M.panel()
  vim.cmd("botright 12new")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.filetype = "nvim-gp-sistema"
  vim.api.nvim_buf_set_name(0, "Sistema Nvim GP")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, M.lines())
  vim.bo.modifiable = false
end

return M
