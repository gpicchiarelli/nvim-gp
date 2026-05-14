return {
  {
    "vim-perl/vim-perl",
    ft = { "perl", "pod" },
    init = function()
      vim.g.perl_fold = 1
      vim.g.perl_fold_blocks = 1
      vim.g.perl_include_pod = 1
      vim.g.perl_extended_vars = 1
      vim.g.perl_sync_dist = 250
    end,
  },
  {
    "majutsushi/tagbar",
    cmd = "TagbarToggle",
  },
  {
    "vim-test/vim-test",
    ft = { "perl", "php", "c", "cpp", "swift" },
    init = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#perl#prove#options"] = "-lv"
    end,
  },
}
