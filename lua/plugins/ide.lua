return {
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
      layout = { min_width = 32, default_direction = "right" },
      show_guides = true,
      filter_kind = false,
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      keywords = {
        TODO = { icon = " ", color = "info" },
        FIXME = { icon = " ", color = "error" },
        SECURITY = { icon = "󰒃 ", color = "warning", alt = { "AUDIT", "RISCHIO" } },
        PERF = { icon = "󰓅 ", color = "hint" },
      },
    },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 36
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ma", function() require("harpoon"):list():add() end, desc = "Marca file" },
      { "<leader>mm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Menu marcatori" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },
  {
    "gbprod/yanky.nvim",
    event = "TextYankPost",
    opts = {
      highlight = { timer = 120 },
      ring = { history_length = 100 },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Salto rapido" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Salto struttura" },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = "Refactor",
    keys = {
      { "<leader>re", mode = "x", function() require("refactoring").refactor("Extract Function") end, desc = "Estrai funzione" },
      { "<leader>rv", mode = "x", function() require("refactoring").refactor("Extract Variable") end, desc = "Estrai variabile" },
      { "<leader>ri", mode = { "n", "x" }, function() require("refactoring").refactor("Inline Variable") end, desc = "Inline variabile" },
    },
    opts = {},
  },
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = false,
      default_view = "body",
      environment_scope = "b",
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = { width = 0.88 },
      plugins = { options = { laststatus = 0 } },
    },
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    opts = {},
  },
}
