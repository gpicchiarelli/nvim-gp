vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●", source = "if_many" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true, header = "Diagnostica" },
})

local signs = {
  Error = "󰅚",
  Warn = "󰀪",
  Hint = "󰌶",
  Info = "󰋽",
}

for type, icon in pairs(signs) do
  vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
end
