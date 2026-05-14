local M = {}
local system = require("utils.system")

function M.setup()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup({ layouts = {
    { elements = { "scopes", "breakpoints", "stacks", "watches" }, size = 40, position = "left" },
    { elements = { "repl", "console" }, size = 12, position = "bottom" },
  } })
  require("nvim-dap-virtual-text").setup()

  dap.adapters.lldb = {
    type = "executable",
    command = system.executable({ "lldb-vscode", "lldb-dap", "codelldb" }),
    name = "lldb",
  }

  dap.configurations.cpp = {
    {
      name = "LLDB: eseguibile",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Eseguibile: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.swift = dap.configurations.cpp

  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug continua" })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })
  vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug stop" })
end

return M
