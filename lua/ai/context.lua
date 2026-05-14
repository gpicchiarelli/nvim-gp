local ai = require("utils.ai")

local M = {}

local defaults = {
  output = ".ai/context.md",
  max_files = 80,
  max_bytes = 240000,
  ignore = {
    ".git",
    ".cache",
    ".data",
    ".state",
    "node_modules",
    "vendor",
    "local",
    "blib",
    "_build",
    "cover_db",
    "nytprof",
    "*.log",
    "*.sqlite",
    "*.db",
    "*.dump",
    "*.pem",
    "*.key",
    ".env",
  },
  extensions = {
    "lua",
    "pl",
    "pm",
    "t",
    "pod",
    "sql",
    "md",
    "sh",
    "zsh",
    "ps1",
    "txt",
    "conf",
    "clp",
    "clips",
    "toml",
    "json",
    "yaml",
    "yml",
  },
}

local function root()
  local markers = { ".git", "cpanfile", "Makefile.PL", "dist.ini", "init.lua" }
  local found = vim.fs.find(markers, { upward = true, path = vim.loop.cwd() })[1]
  return found and vim.fs.dirname(found) or vim.loop.cwd()
end

local function extension(path)
  return path:match("%.([^./]+)$") or ""
end

local function allowed(path)
  local ext = extension(path)
  for _, item in ipairs(defaults.extensions) do
    if item == ext then
      return true
    end
  end
  return vim.endswith(path, "Makefile") or vim.endswith(path, "LICENSE") or vim.endswith(path, ".gitignore")
end

local function ignored(path)
  for _, pattern in ipairs(defaults.ignore) do
    local plain = pattern:gsub("%*", "")
    if path:find(plain, 1, true) then
      return true
    end
  end
  return false
end

local function project_ignore(cwd)
  local path = cwd .. "/.aiignore"
  if not vim.loop.fs_stat(path) then
    return {}
  end
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok then
    return {}
  end
  local patterns = {}
  for _, line in ipairs(lines) do
    line = vim.trim(line)
    if line ~= "" and not vim.startswith(line, "#") then
      local pattern = line:gsub("/$", "")
      table.insert(patterns, pattern)
    end
  end
  return patterns
end

local function ignored_by_project(path, patterns)
  for _, pattern in ipairs(patterns) do
    local plain = pattern:gsub("%*", "")
    if plain ~= "" and path:find(plain, 1, true) then
      return true
    end
  end
  return false
end

local function files()
  local cwd = root()
  local project_patterns = project_ignore(cwd)
  local previous = vim.fn.getcwd()
  vim.fn.chdir(cwd)
  local found = vim.fn.systemlist({ "rg", "--files", "--hidden", "--glob", "!.git" })
  if vim.v.shell_error ~= 0 then
    found = vim.fn.systemlist({ "find", ".", "-type", "f" })
  end
  vim.fn.chdir(previous)

  local selected = {}
  for _, file in ipairs(found) do
    file = file:gsub("^%./", "")
    if allowed(file) and not ignored(file) and not ignored_by_project(file, project_patterns) then
      table.insert(selected, file)
    end
    if #selected >= defaults.max_files then
      break
    end
  end
  table.sort(selected)
  return cwd, selected
end

local function read_limited(path, remaining)
  local stat = vim.loop.fs_stat(path)
  if not stat or stat.size > remaining then
    return nil, stat and stat.size or 0
  end
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok then
    return nil, 0
  end
  return lines, stat.size
end

function M.build()
  local cwd, selected = files()
  local out = {
    "# Contesto AI Nvim GP",
    "",
    "Generato: " .. os.date("%Y-%m-%d %H:%M:%S"),
    "Root: " .. cwd,
    "Policy: locale, esplicito, senza segreti.",
    "",
    "## Istruzioni per agenti",
    "",
    "- Preferire patch piccole e verificabili.",
    "- Non modificare file non richiesti.",
    "- Usare `rg` per cercare e quickfix/test per validare.",
    "- Per Perl: mantenere strict/warnings, Perl::Critic severity 5 e perltidy.",
    "",
    "## File inclusi",
    "",
  }

  for _, file in ipairs(selected) do
    table.insert(out, "- `" .. file .. "`")
  end
  table.insert(out, "")

  local remaining = defaults.max_bytes
  for _, file in ipairs(selected) do
    local abs = cwd .. "/" .. file
    local lines, size = read_limited(abs, remaining)
    if lines then
      remaining = remaining - size
      table.insert(out, "## `" .. file .. "`")
      table.insert(out, "")
      table.insert(out, "```" .. extension(file))
      vim.list_extend(out, lines)
      table.insert(out, "```")
      table.insert(out, "")
    else
      table.insert(out, "## `" .. file .. "`")
      table.insert(out, "")
      table.insert(out, "_Omissis: file troppo grande o non leggibile._")
      table.insert(out, "")
    end
    if remaining <= 0 then
      table.insert(out, "_Budget contesto esaurito._")
      break
    end
  end

  return out
end

function M.write()
  local cwd = root()
  local path = cwd .. "/" .. defaults.output
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(M.build(), path)
  vim.notify("Contesto AI scritto: " .. path, vim.log.levels.INFO)
  vim.cmd("edit " .. vim.fn.fnameescape(path))
end

function M.policy_buffer()
  vim.cmd("vnew")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.filetype = "markdown"
  vim.api.nvim_buf_set_name(0, "AI Policy Nvim GP")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, ai.policy())
  vim.bo.modifiable = false
end

function M.prompt_buffer(kind)
  local prompts = require("ai.prompts")
  local lines = prompts[kind or "review"] or prompts.review
  vim.cmd("vnew")
  vim.bo.filetype = "markdown"
  vim.api.nvim_buf_set_name(0, "Prompt AI - " .. (kind or "review"))
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

function M.setup()
  vim.g.nvim_gp_ai_mode = "locale"
end

return M
