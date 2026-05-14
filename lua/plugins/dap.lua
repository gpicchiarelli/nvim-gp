return {
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapTerminate", "DapToggleBreakpoint" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("dap.config").setup()
    end,
  },
}
