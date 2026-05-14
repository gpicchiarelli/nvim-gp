local telemetry = require("utils.telemetry")

local apple_light_theme = {
  normal = {
    a = { fg = "#ffffff", bg = "#1d1d1f", gui = "bold" },
    b = { fg = "#1d1d1f", bg = "#e8e8ed" },
    c = { fg = "#1d1d1f", bg = "#f5f5f7" },
  },
  insert = {
    a = { fg = "#ffffff", bg = "#0071e3", gui = "bold" },
    b = { fg = "#1d1d1f", bg = "#e8e8ed" },
    c = { fg = "#1d1d1f", bg = "#f5f5f7" },
  },
  visual = {
    a = { fg = "#ffffff", bg = "#6e6e73", gui = "bold" },
    b = { fg = "#1d1d1f", bg = "#e8e8ed" },
    c = { fg = "#1d1d1f", bg = "#f5f5f7" },
  },
  replace = {
    a = { fg = "#ffffff", bg = "#bf4800", gui = "bold" },
    b = { fg = "#1d1d1f", bg = "#e8e8ed" },
    c = { fg = "#1d1d1f", bg = "#f5f5f7" },
  },
  command = {
    a = { fg = "#ffffff", bg = "#424245", gui = "bold" },
    b = { fg = "#1d1d1f", bg = "#e8e8ed" },
    c = { fg = "#1d1d1f", bg = "#f5f5f7" },
  },
  inactive = {
    a = { fg = "#86868b", bg = "#f5f5f7" },
    b = { fg = "#86868b", bg = "#f5f5f7" },
    c = { fg = "#86868b", bg = "#f5f5f7" },
  },
}

return {
  options = {
    theme = apple_light_theme,
    globalstatus = true,
    component_separators = { left = " ", right = " " },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = { "alpha" } },
  },
  sections = {
    lualine_a = {
      { "mode", fmt = function(value) return value:lower() end },
    },
    lualine_b = {
      { "branch", icon = "", color = { fg = "#424245" } },
      { "diff", symbols = { added = "+", modified = "~", removed = "-" } },
    },
    lualine_c = {
      { "filename", path = 1, symbols = { modified = " +", readonly = " ro", unnamed = "senza nome" } },
      { "diagnostics", sources = { "nvim_diagnostic" }, symbols = { error = "E ", warn = "W ", info = "I ", hint = "H " } },
    },
    lualine_x = {
      { telemetry.status_cpu, color = { fg = "#1d1d1f" } },
      { telemetry.status_ram, color = { fg = "#6e6e73" } },
      { telemetry.status_net, color = { fg = "#0071e3" } },
      { "encoding", color = { fg = "#86868b" } },
      { "filetype", icon = false, icon_only = false, colored = false },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
}
