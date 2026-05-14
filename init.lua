vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.bootstrap")
require("core.options")
require("core.diagnostics")
require("core.health")
require("workspace.overrides").setup()
require("ai.context").setup()
require("plugins")
require("core.autocmd")
require("commands")
require("keymaps")
