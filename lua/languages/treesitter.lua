local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter-parsers"
local has_tree_sitter_cli = vim.fn.executable("tree-sitter") == 1

local desired_ensure_installed = {
  "perl",
  "pod",
  "sql",
  "c",
  "cpp",
  "cmake",
  "commonlisp",
  "php",
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "yaml",
  "markdown",
  "markdown_inline",
  "lua",
  "vim",
  "bash",
  "dockerfile",
  "regex",
  "swift",
}

return {
  parser_install_dir = parser_install_dir,
  desired_ensure_installed = desired_ensure_installed,
  ensure_installed = has_tree_sitter_cli and desired_ensure_installed or {},
  sync_install = false,
  auto_install = has_tree_sitter_cli,
  highlight = { enabled = true },
  indent = { enabled = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
