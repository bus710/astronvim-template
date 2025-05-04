if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
-- https://terminalprogrammer.com/neovim-setup-for-zig
-- :lua print(vim.fn.getcwd())

-- Install either package if lldb gets updated
-- sudo apt install lldb 
-- sudo apt install clangd


local dap = require "dap"
local dapui = require "dapui"

-- To get the binary file name, which should be same as the project root directory
function getcwdtail()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

dap.adapters.lldb = {
  type = "executable",
  -- command = "/usr/bin/lldb-vscode-16",
  command = "/usr/bin/lldb-dap-19",
  name = "lldb",
}
dap.configurations.zig = {
  {
    name = "LLDB: Launch Custom",
    type = "lldb",
    request = "launch",
    program = "${workspaceFolder}/zig-out/bin/" .. getcwdtail(),
    -- program = function()
    --   return vim.fn.input(
    --     'Path to executable for Zig: ',
    --     vim.fn.getcwd() .. '/zig-out/bin/' .. getcwdtail(),
    --     'file')
    -- end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end

return {}
