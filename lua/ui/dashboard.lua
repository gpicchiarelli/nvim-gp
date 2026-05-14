local M = {}

function M.setup()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  local telemetry = require("utils.telemetry").snapshot()

  dashboard.section.header.val = {
    "NEOVIM GP",
    "Cockpit UNIX Perl / PostgreSQL",
    telemetry.host .. " · " .. telemetry.os .. " · CPU " .. telemetry.load .. " · RAM " .. telemetry.ram,
  }

  dashboard.section.buttons.val = {
    dashboard.button("SPC f f", "  Cerca file", ":Telescope find_files<CR>"),
    dashboard.button("SPC g g", "󰱼  Cerca testo", ":Telescope live_grep<CR>"),
    dashboard.button("SPC p p", "󰉋  Apri progetto", ":Neotree filesystem reveal left<CR>"),
    dashboard.button("SPC b b", "  Apri database", ":DBUI<CR>"),
    dashboard.button("SPC t t", "󰙨  Esegui test Perl", ":PerlProveFile<CR>"),
    dashboard.button("SPC s i", "󰍛  Sistema", ":Sistema<CR>"),
    dashboard.button("SPC h s", "󰒓  Salute ambiente", ":Salute<CR>"),
    dashboard.button("q", "󰩈  Esci", ":qa<CR>"),
  }

  dashboard.section.footer.val = "Rete " .. (telemetry.ip ~= "" and telemetry.ip or "n/d") .. " · uptime " .. telemetry.uptime
  alpha.setup(dashboard.opts)
end

return M
