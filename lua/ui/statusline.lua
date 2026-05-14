local telemetry = require("utils.telemetry")

return {
  options = {
    theme = "catppuccin",
    globalstatus = true,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = { "alpha" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = {
      { "filename", path = 1 },
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_x = {
      { telemetry.status_cpu, color = { fg = "#a6e3a1" } },
      { telemetry.status_ram, color = { fg = "#f9e2af" } },
      { telemetry.status_net, color = { fg = "#89b4fa" } },
      "encoding",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}
