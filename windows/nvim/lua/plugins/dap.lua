local dap = require("dap")
local dapui = require("dapui")

-- Breakpoint sign: red dot instead of B
vim.fn.sign_define("DapBreakpoint", { text = " ●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = " ●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })

-- Setup nvim-dap-ui
dapui.setup()

-- Automatically open and close dap-ui when debugging
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Keymaps for debugging
vim.keymap.set("n", "<leader>xr", function() dap.continue() end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<leader>xo", function() dap.step_over() end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<leader>xi", function() dap.step_into() end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<leader>xO", function() dap.step_out() end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>xb", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>xB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  { desc = "Debug: Set Conditional Breakpoint" })

-- codelldb adapter (supports runInTerminal for proper stdout/stdin)
-- Installed at D:\dev\codelldb from https://github.com/vadimcn/codelldb/releases
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "D:/dev/codelldb/extension/adapter/codelldb.exe",
    args = { "--port", "${port}" },
    detached = false,
  },
}

dap.configurations.cpp = {
  {
    name = "Compile & Debug C++ file",
    type = "codelldb",
    request = "launch",
    program = function()
      local file = vim.fn.expand("%:p")
      local out = vim.fn.expand("%:p:r") .. ".exe"

      print("Compiling " .. file .. " with g++...")

      local cmd = string.format('g++ -g "%s" -o "%s"', file, out)
      vim.fn.system(cmd)
      if vim.v.shell_error ~= 0 then
        print("Compilation failed!")
        return nil
      end

      print("Compilation successful, starting debugger...")
      return out
    end,
    cwd = function()
      return vim.fn.expand("%:p:h")
    end,
    stopOnEntry = false,
    terminal = "integrated",
  },
  {
    name = "Debug existing executable",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = function()
      return vim.fn.expand("%:p:h")
    end,
    stopOnEntry = false,
    terminal = "integrated",
  },
}

dap.configurations.c = dap.configurations.cpp
