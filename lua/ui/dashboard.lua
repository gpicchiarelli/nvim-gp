local M = {}

function M.setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  local telemetry = require("utils.telemetry").snapshot()

  dashboard.section.header.val = {
    "Nvim GP",
    "",
    "Perl. PostgreSQL. CLIPS. UNIX.",
    "",
    telemetry.host .. "  " .. telemetry.os .. "  CPU " .. telemetry.load .. "  RAM " .. telemetry.ram,
  }

  dashboard.section.buttons.val = {
    dashboard.button("SPC f f", "Cerca file", ":Telescope find_files<CR>"),
    dashboard.button("SPC g g", "Cerca testo", ":Telescope live_grep<CR>"),
    dashboard.button("SPC p p", "Progetto", ":Neotree filesystem reveal left<CR>"),
    dashboard.button("SPC t t", "Test Perl", ":PerlProveFile<CR>"),
    dashboard.button("SPC b b", "Database", ":DBUI<CR>"),
    dashboard.button("SPC e x", "CLIPS XS", ":CLIPSPerlXSCheck<CR>"),
    dashboard.button("SPC a c", "Contesto AI", ":AIContesto<CR>"),
    dashboard.button("SPC s i", "Sistema", ":Sistema<CR>"),
    dashboard.button("q", "Esci", ":qa<CR>"),
  }

  dashboard.section.footer.val = "rete " .. (telemetry.ip ~= "" and telemetry.ip or "n/d") .. "   uptime " .. telemetry.uptime
  dashboard.opts.layout = {
    { type = "padding", val = 5 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 2 },
    dashboard.section.footer,
  }
  alpha.setup(dashboard.opts)
end

return M
