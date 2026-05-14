return {
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      size = 18,
      open_mapping = [[<c-\>]],
      direction = "horizontal",
      shade_terminals = false,
      persist_size = true,
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
}
