local M = {}

function M.todo()
  vim.cmd("TodoTrouble")
end

function M.audit()
  vim.cmd("TodoTrouble keywords=SECURITY,AUDIT,RISCHIO,FIXME")
end

function M.outline()
  vim.cmd("AerialToggle")
end

function M.undo()
  vim.cmd("UndotreeToggle")
end

function M.tasks()
  vim.cmd("OverseerToggle")
end

function M.run_task()
  vim.cmd("OverseerRun")
end

function M.rest_run()
  local ok, kulala = pcall(require, "kulala")
  if ok then
    kulala.run()
  else
    vim.notify("Kulala non disponibile per questo buffer.", vim.log.levels.WARN)
  end
end

function M.rest_scratch()
  vim.cmd("vnew")
  vim.bo.filetype = "http"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "### Health check locale",
    "GET http://localhost:3000/health",
    "Accept: application/json",
    "",
  })
end

function M.command_palette()
  vim.cmd("Telescope commands")
end

function M.symbols()
  vim.cmd("Telescope lsp_document_symbols")
end

function M.workspace_symbols()
  vim.cmd("Telescope lsp_dynamic_workspace_symbols")
end

function M.project_files()
  vim.cmd("Telescope find_files")
end

function M.resume_search()
  vim.cmd("Telescope resume")
end

return M
