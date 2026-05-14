local M = {}

function M.attach(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Vai a definizione")
  map("n", "gD", vim.lsp.buf.declaration, "Vai a dichiarazione")
  map("n", "gr", vim.lsp.buf.references, "Referenze")
  map("n", "gi", vim.lsp.buf.implementation, "Implementazione")
  map("n", "K", vim.lsp.buf.hover, "Documentazione hover")
  map("n", "<leader>lr", vim.lsp.buf.rename, "Rinomina")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Azione codice")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, "Firma")
  map("n", "<leader>ld", vim.lsp.buf.type_definition, "Definizione tipo")
  map("n", "<leader>lf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, "Formato LSP")
end

return M
