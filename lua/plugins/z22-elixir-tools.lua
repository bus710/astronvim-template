-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This function will run when open an elixir file.



-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#elixir
-- https://github.com/elixir-lsp/elixir-ls?tab=readme-ov-file#debug-adapter-configuration-options
-- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/dap.lua

--[
-- Also don't forget to install LSP and TS packages 
--   (if don't, the "slow LSP response" error will appear):
-- :TSInstall! elixir
-- :TSInstall! heex
-- :TSInstall! eex
-- :LspInstall elixirls
--]

-- For each project, create the .vscode/launch.json file 
-- ... with the cp-elixir-vscode-launch-json alias command

local dap = require "dap"
local dapui = require "dapui"
local adapter_path = "/home/bus710/.elixir-ls/debug_adapter.sh"

dap.adapters.mix_task = {
  type = "executable",
  command = adapter_path,
  args = {}
}
dap.configurations.elixir = {
  {
    type = "mix_task",
    name = "mix run",
    task = "run",
    request = "launch",
    projectDir = "${workspaceFolder}",
    -- requireFiles = {
    --   "test/**/test_helper.exs",
    --   "test/**/*_test.exs"
    -- }
    -- taskArgs = {"--trace"},
    -- startApps = true, -- for Phoenix projects
    -- exitAfterTaskReturns = false,
    -- debugAutoInterpretAllModules = false,
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end

return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require "elixir"
      local elixirls = require "elixir.elixirls"

      elixir.setup {
        nextls = { enable = false },
        credo = { enable = true },
        elixirls = {
          enable = true,
          -- https://github.com/elixir-tools/elixir-tools.nvim/issues/143
          -- ls ~/.cache/nvim/elixir-tools.nvim/installs/elixir-lsp/elixir-ls/
          -- tag = "v0.15.1",
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
            vim.keymap.set("n", "gr", vim.lsp.buf.references)
            vim.keymap.set("n", "K", vim.lsp.buf.hover)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}

-- :lua vim.lsp.buf.definition() on a token
-- :LspInfo
-- :LspLog
-- :ElixirOutputPanel
