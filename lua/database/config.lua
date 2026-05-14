local M = {}

function M.setup()
  vim.g.db_ui_use_nerd_fonts = 0
  vim.g.db_ui_show_database_icon = 0
  vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod"
  vim.g.db_ui_execute_on_save = 0
  vim.g.db_ui_win_position = "left"
  vim.g.db_ui_winwidth = 42
  vim.g.db_ui_table_helpers = {
    postgresql = {
      Conta = "select count(*) from {table}",
      Campione = "select * from {table} limit 50",
      Struttura = "\\d+ {table}",
      Indici = "select indexname, indexdef from pg_indexes where tablename = '{table}'",
    },
    mysql = {
      Conta = "select count(*) from {table}",
      Campione = "select * from {table} limit 50",
      Struttura = "describe {table}",
    },
    sqlite = {
      Conta = "select count(*) from {table}",
      Campione = "select * from {table} limit 50",
      Struttura = ".schema {table}",
    },
  }
end

function M.query()
  vim.cmd("DB")
end

return M
