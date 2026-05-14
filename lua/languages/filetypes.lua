local M = {}

function M.setup()
  vim.filetype.add({
    extension = {
      clp = "clips",
      clips = "clips",
    },
    filename = {
      ["rules.clp"] = "clips",
    },
  })
end

return M
