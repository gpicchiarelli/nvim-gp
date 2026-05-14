local M = {}

local function project_root()
  local markers = { ".nvim-gp.lua", "cpanfile", "Makefile.PL", "dist.ini", ".git" }
  local found = vim.fs.find(markers, { upward = true, path = vim.loop.cwd() })[1]
  return found and vim.fs.dirname(found) or vim.loop.cwd()
end

function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("NvimGpOverrideLocali", { clear = true }),
    callback = function()
      local override = project_root() .. "/.nvim-gp.lua"
      if vim.loop.fs_stat(override) then
        vim.schedule(function()
          vim.ui.select({ "no", "si" }, {
            prompt = "Caricare override locale .nvim-gp.lua?",
          }, function(choice)
            if choice == "si" then
              dofile(override)
              vim.notify("Override locale caricato: " .. override, vim.log.levels.INFO)
            end
          end)
        end)
      end
    end,
  })
end

return M
