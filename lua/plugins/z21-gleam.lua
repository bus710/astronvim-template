-- In progress...

-- Until there is a new DAP debugger coming out, use the erl.
-- gleam shell
-- > os:cmd("gleam build").
-- > c(hello).
-- > hello:main().
--
-- > os:cmd("gleam build"), c(hello), hello:main().


-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This function will run when open an elixir file.



-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#elixir
-- https://github.com/elixir-lsp/elixir-ls?tab=readme-ov-file#debug-adapter-configuration-options
-- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua

--[
-- Also don't forget to install LSP and TS packages 
--   (if don't, the "slow LSP response" error will appear):
-- :TSInstall! erlang
-- :LspInstall erlangls
--]

-- For each project, create the .vscode/launch.json file 
-- ... with the get-elixir-vscode-launch-json alias command


-- local dap = require "dap"
-- local dapui = require "dapui"
-- -- local lsp_path= "/home/bus710/.erlang_ls/bin/erlang_ls"
-- local lsp_path= "/home/bus710/.local/share/nvim/mason/bin/erlang_ls"
--
-- dap.adapters.erlang_ls= {
--   type = "executable",
--   command = lsp_path,
--   args = {}
-- }
-- dap.configurations.gleam= {
--   {
--     name = "erlang_ls",
--     type = "erlang_ls",
--     task = "run",
--     request = "launch",
--     projectDir = "${workspaceFolder}",
--     -- requireFiles = {
--     --   "test/**/test_helper.exs",
--     --   "test/**/*_test.exs"
--     -- }
--     -- taskArgs = {"--trace"},
--     -- startApps = true, -- for Phoenix projects
--     -- exitAfterTaskReturns = false,
--     -- debugAutoInterpretAllModules = false,
--   },
-- }
--
-- dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
-- dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
-- dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end
--
return {}


