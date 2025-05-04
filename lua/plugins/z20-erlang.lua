-- Please use VSCODE for debugging
-- Create a new erlang project with rebar3 (rebar3 new app myapp)
-- Open the project with VSCODE
-- Set a break point in the myapp_app.erl file
--   in the start function, add "io:fwrite("hello\n"),"
-- Create the launch.json in the debugging tab.
-- Start a debugging session. It will open a new erl shell.
-- In the erl shell, call the function like "myapp_app:start(1, 2)."


-- Below configs don't work.

if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local dap = require "dap"
local dapui = require "dapui"
-- local lsp_path= "/home/bus710/.erlang_ls/bin/erlang_ls"
local lsp_path= "/home/bus710/.local/share/nvim/mason/bin/erlang_ls"

dap.adapters.erlang_ls= {
  type = "executable",
  command = lsp_path,
  args = {}
}

dap.configurations.erlang= {
  {
    type = "erlang_ls",
    name = "attach",
    request = "attach",
    projectDir = "${workspaceRoot}",
    remoteNode = "dap-project-node@localhost",
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end

return {}
