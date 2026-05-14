local defaults = require("plugins.defaults")

require("lazy").setup({
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.ide" },
  { import = "plugins.lsp" },
  { import = "plugins.dap" },
  { import = "plugins.database" },
  { import = "plugins.git" },
  { import = "plugins.perl" },
  { import = "plugins.languages" },
  { import = "plugins.terminal" },
}, defaults)
