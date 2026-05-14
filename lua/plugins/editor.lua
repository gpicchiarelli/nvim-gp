return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "Cerca > ",
          selection_caret = "> ",
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = { prompt_position = "top" },
          file_ignore_patterns = { "%.git/", "local/", "blib/", "_build/" },
        },
      })
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
    opts = {
      close_if_last_window = true,
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          default = "",
        },
        git_status = {
          symbols = {
            added = "+",
            deleted = "-",
            modified = "~",
            renamed = "r",
            untracked = "?",
            ignored = "i",
            unstaged = "u",
            staged = "s",
            conflict = "!",
          },
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      window = { width = 34 },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    build = function()
      if vim.fn.executable("tree-sitter") == 1 then
        vim.cmd("TSUpdate")
      else
        vim.notify("tree-sitter CLI non trovato: salto TSUpdate. Installa tree-sitter-cli con MacPorts.", vim.log.levels.WARN)
      end
    end,
    opts = require("languages.treesitter"),
    config = function(_, opts)
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify(
          "nvim-treesitter.configs non disponibile. Esegui :Lazy sync per riallineare nvim-treesitter al branch master.",
          vim.log.levels.WARN
        )
        return
      end
      if opts.parser_install_dir then
        vim.fn.mkdir(opts.parser_install_dir, "p")
        vim.opt.runtimepath:prepend(opts.parser_install_dir)
      end
      if vim.fn.executable("tree-sitter") ~= 1 then
        opts.ensure_installed = {}
        opts.auto_install = false
        vim.notify(
          "tree-sitter CLI non trovato: installazione parser disabilitata. Esegui `sudo port install tree-sitter-cli` o `make ensure-macports`.",
          vim.log.levels.WARN
        )
      end
      local setup_ok, setup_err = pcall(configs.setup, opts)
      if not setup_ok then
        vim.notify("nvim-treesitter disabilitato: " .. tostring(setup_err), vim.log.levels.WARN)
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = require("languages.formatters"),
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      require("languages.lint").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    opts = require("workspace.tasks"),
  },
  {
    "rmagatti/auto-session",
    event = "VimEnter",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "/", vim.fn.expand("~"), "/tmp" },
      auto_session_enable_last_session = false,
    },
  },
}
