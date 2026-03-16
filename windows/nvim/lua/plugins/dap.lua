local dap = require("dap")
local dapui = require("dapui")

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

-- Configure GDB as the debug adapter
-- NOTE: This requires GDB version 14.1 or higher. MinGW comes with GDB.
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

-- Configure C++ debugging
dap.configurations.cpp = {
  {
    name = "Compile & Debug C++ file",
    type = "gdb",
    request = "launch",
    program = function()
      local file_dir = vim.fn.expand("%:p:h")
      local file_name = vim.fn.expand("%:t")
      local out_name = vim.fn.expand("%:t:r") .. ".exe"
      local out_path = file_dir .. "\\" .. out_name

      -- Print compilation message
      print("Compiling " .. file_name .. " with g++...")

      -- Compile the current file with debugging symbols (-g) and relative path
      -- This ensures GDB stores a relative path in DWARF to match nvim-dap's breakpoint paths
      local obj = vim.system({ 'g++', '-g', file_name, '-o', out_name }, { cwd = file_dir }):wait()
      if obj.code ~= 0 then
        print("Compilation failed!\n" .. obj.stderr)
        return nil
      end

      print("Compilation successful, starting debugger...")
      return out_path
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    console = "integratedTerminal",
    runInTerminal = false,
  },
  {
    name = "Debug existing executable",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
    console = "integratedTerminal",
    runInTerminal = false,
  },
}

-- Reuse the C++ configuration for C files
dap.configurations.c = dap.configurations.cpp
