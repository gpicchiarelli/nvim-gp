local M = {}

function M.setup()
  local lint = require("lint")
  lint.linters_by_ft = {
    perl = { "perlcritic" },
    markdown = { "markdownlint" },
    yaml = { "yamllint" },
    php = { "php" },
    sh = { "shellcheck" },
    bash = { "shellcheck" },
    zsh = { "shellcheck" },
  }

  lint.linters.perlcritic = {
    cmd = "perlcritic",
    stdin = false,
    append_fname = true,
    args = { "--severity", "5", "--verbose", "%f:%l:%c:%m\n" },
    stream = "stdout",
    ignore_exitcode = true,
    parser = require("lint.parser").from_pattern(
      "([^:]+):(%d+):(%d+):(.*)",
      { "file", "lnum", "col", "message" },
      { source = "perlcritic", severity = vim.diagnostic.severity.WARN }
    ),
  }

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("NvimGpLint", { clear = true }),
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
