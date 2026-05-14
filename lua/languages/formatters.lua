return {
  formatters_by_ft = {
    perl = { "perltidy" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    php = { "php_cs_fixer" },
    swift = { "swift_format" },
    lua = { "stylua" },
    sql = { "sql_formatter" },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    json = { "jq" },
    yaml = { "yamlfmt" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
  formatters = {
    perltidy = {
      command = "perltidy",
      args = { "-q", "-st", "-se" },
      stdin = true,
    },
    swift_format = {
      command = vim.fn.executable("swift-format") == 1 and "swift-format" or "swiftformat",
      args = { "format", "--in-place", "$FILENAME" },
      stdin = false,
    },
  },
  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == "perl" or ft == "c" or ft == "cpp" or ft == "php" or ft == "swift" or ft == "lua" then
      return { timeout_ms = 3000, lsp_format = "fallback" }
    end
    return nil
  end,
}
