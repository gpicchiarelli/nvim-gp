local t = require("tests.minit")
local features = require("tests.features")

local function file_exists(path)
  return vim.loop.fs_stat(path) ~= nil
end

local function read(path)
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok then
    return ""
  end
  return table.concat(lines, "\n")
end

t.test("ogni feature dichiarata ha artefatti", function()
  for _, feature in ipairs(features) do
    t.assert_truthy(feature.name and feature.name ~= "", "feature senza nome")
    t.assert_truthy(feature.docs or feature.files or feature.modules or feature.commands, "feature senza artefatti: " .. feature.name)
  end
end)

t.test("documentazione feature presente", function()
  for _, feature in ipairs(features) do
    local keywords = feature.keywords or { feature.name }
    for _, path in ipairs(feature.docs or {}) do
      t.assert_truthy(file_exists(path), feature.name .. " doc mancante: " .. path)
      local content = read(path):lower()
      local found = false
      for _, keyword in ipairs(keywords) do
        found = found or content:find(keyword:lower(), 1, true) ~= nil
      end
      t.assert_truthy(found, feature.name .. " non citata in " .. path)
    end
  end
end)

t.test("file feature presenti", function()
  for _, feature in ipairs(features) do
    for _, path in ipairs(feature.files or {}) do
      t.assert_truthy(file_exists(path), feature.name .. " file mancante: " .. path)
    end
  end
end)

t.test("moduli feature caricabili", function()
  for _, feature in ipairs(features) do
    for _, module in ipairs(feature.modules or {}) do
      local ok, err = pcall(require, module)
      t.assert_truthy(ok, feature.name .. " modulo non caricabile " .. module .. ": " .. tostring(err))
    end
  end
end)

t.test("comandi feature registrati", function()
  local commands = vim.api.nvim_get_commands({})
  for _, feature in ipairs(features) do
    for _, command in ipairs(feature.commands or {}) do
      t.assert_truthy(commands[command], feature.name .. " comando mancante: " .. command)
    end
  end
end)

t.run()
