local t = require("tests.minit")

t.test("telemetria statusline sicura", function()
  local telemetry = require("utils.telemetry")
  local value = telemetry.status_safe("x<y> 100%\n")
  t.assert_truthy(not value:find("[<>]"), "statusline contiene < o >")
  t.assert_truthy(value:find("%%%%"), "percentuale non escapata")
end)

t.test("AI context costruibile", function()
  local context = require("ai.context")
  local lines = context.build()
  t.assert_truthy(#lines > 20, "contesto AI troppo piccolo")
  t.assert_eq(lines[1], "# Contesto AI Nvim GP")
end)

t.test("prompt AI CLIPS presente", function()
  local prompts = require("ai.prompts")
  t.assert_truthy(prompts.clips, "prompt CLIPS mancante")
end)

t.test("treesitter contiene linguaggi core", function()
  local config = require("languages.treesitter")
  local installed = {}
  for _, lang in ipairs(config.desired_ensure_installed) do
    installed[lang] = true
  end
  for _, lang in ipairs({ "perl", "sql", "c", "cpp", "php", "swift", "markdown" }) do
    t.assert_truthy(installed[lang], "treesitter mancante: " .. lang)
  end
  t.assert_eq(config.auto_install, vim.fn.executable("tree-sitter") == 1)
end)

t.test("formatter Perl configurato", function()
  local formatters = require("languages.formatters")
  t.assert_truthy(formatters.formatters_by_ft.perl, "formatter Perl mancante")
end)

t.test("nvim-treesitter usa branch compatibile", function()
  local specs = require("plugins.editor")
  local treesitter
  for _, spec in ipairs(specs) do
    if spec[1] == "nvim-treesitter/nvim-treesitter" then
      treesitter = spec
      break
    end
  end
  t.assert_truthy(treesitter, "spec nvim-treesitter mancante")
  t.assert_eq(treesitter.branch, "master")
end)

t.test("modulo CLIPS carica", function()
  local clips = require("expert.clips")
  t.assert_truthy(type(clips.perl_xs_check) == "function")
  t.assert_truthy(type(clips.scratch) == "function")
end)

t.test("profilo UI chiaro senza Nerd Font obbligatorio", function()
  local files = {
    "lua/core/options.lua",
    "lua/core/diagnostics.lua",
    "lua/database/config.lua",
    "lua/plugins/editor.lua",
    "lua/plugins/ide.lua",
    "lua/plugins/ui.lua",
    "lua/ui/statusline.lua",
  }
  local forbidden = {
    "have_nerd_font = true",
    "db_ui_use_nerd_fonts = 1",
    'background = "dark"',
    'flavour = "mocha"',
    "",
    "",
    "󰒃",
    "󰓅",
    "󰅚",
    "󰀪",
    "󰌶",
    "󰋽",
    "➤",
    "●",
  }

  for _, file in ipairs(files) do
    local content = table.concat(vim.fn.readfile(file), "\n")
    for _, value in ipairs(forbidden) do
      t.assert_truthy(not content:find(value, 1, true), file .. " contiene glyph/opzione vietata: " .. value)
    end
  end
end)

t.test("bootstrap usa gate ragionati", function()
  local macports = table.concat(vim.fn.readfile("scripts/ensure_macports.sh"), "\n")
  local debian = table.concat(vim.fn.readfile("scripts/bootstrap_debian.sh"), "\n")
  local windows = table.concat(vim.fn.readfile("scripts/bootstrap_windows.ps1"), "\n")

  t.assert_truthy(macports:find("command_gate_ok", 1, true), "ensure_macports senza gate comandi")
  t.assert_truthy(macports:find("perl_module_gate_ok", 1, true), "ensure_macports senza gate moduli Perl")
  t.assert_truthy(macports:find("NVIM_GP_DRY_RUN", 1, true), "ensure_macports senza dry-run")
  t.assert_truthy(macports:find("NVIM_GP_MACPORTS_UPGRADE", 1, true), "upgrade MacPorts deve essere opt-in")

  t.assert_truthy(debian:find("command_gate_ok", 1, true), "bootstrap Debian senza gate comandi")
  t.assert_truthy(not debian:find("xargs sudo apt%-get install", 1, false), "bootstrap Debian installa lista cieca")

  t.assert_truthy(windows:find("Test%-CommandGate", 1, false), "bootstrap Windows senza gate comandi")
  t.assert_truthy(not windows:find("Get%-Content .*winget%-packages", 1, false), "bootstrap Windows installa lista cieca")
end)

t.test("statusline non usa tema lualine esterno fragile", function()
  local statusline = require("ui.statusline")
  t.assert_truthy(type(statusline.options.theme) == "table", "lualine deve usare tema locale")
  t.assert_truthy(statusline.options.theme.normal, "tema lualine locale incompleto")
end)

t.run()
