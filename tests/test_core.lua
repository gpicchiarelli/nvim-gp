local t = require("tests.minit")

t.test("leader configurato", function()
  t.assert_eq(vim.g.mapleader, " ")
  t.assert_eq(vim.g.maplocalleader, " ")
end)

t.test("opzioni essenziali", function()
  t.assert_truthy(vim.o.termguicolors)
  t.assert_eq(vim.o.background, "light")
  t.assert_eq(vim.g.have_nerd_font, false)
  t.assert_truthy(vim.o.undofile)
  t.assert_eq(vim.o.laststatus, 3)
end)

t.test("comandi italiani principali", function()
  local required = {
    "ApriProgetto",
    "CercaFile",
    "CriticaPerl",
    "EseguiTest",
    "ApriDatabase",
    "Sistema",
    "AIContesto",
    "CLIPSPerlXSCheck",
  }
  local commands = vim.api.nvim_get_commands({})
  for _, name in ipairs(required) do
    t.assert_truthy(commands[name], "comando mancante: " .. name)
  end
end)

t.test("keymap leader principali", function()
  local maps = vim.api.nvim_get_keymap("n")
  local by_lhs = {}
  for _, map in ipairs(maps) do
    by_lhs[map.lhs] = true
  end
  for _, lhs in ipairs({ " ff", " tt", " bd", " ec", " ac" }) do
    t.assert_truthy(by_lhs[lhs], "keymap mancante: " .. lhs)
  end
end)

t.test("filetype CLIPS", function()
  vim.cmd("filetype on")
  vim.cmd("edit test-rules.clp")
  t.assert_eq(vim.bo.filetype, "clips")
  vim.cmd("bwipe!")
end)

t.run()
