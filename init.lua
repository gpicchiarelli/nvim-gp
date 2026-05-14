vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.bootstrap")
require("core.options")
require("core.diagnostics")
require("core.health")
require("languages.filetypes").setup()
require("workspace.overrides").setup()
require("ai.context").setup()

if vim.env.NVIM_GP_PHASE0 == "1" then
  require("core.autocmd")
  require("commands")
  require("keymaps")
  return
end

require("plugins")
require("core.autocmd")
require("commands")
require("keymaps")
