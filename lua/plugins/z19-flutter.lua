-- Flutter / Dart (web + WASM)
-- Run WASM:   :FlutterRun --wasm -d chrome     (dart2wasm / WasmGC)
-- Run JS:     :FlutterRun -d chrome
-- Reload/Restart/Quit: :FlutterReload  :FlutterRestart  :FlutterQuit
-- DevTools:   :FlutterDevTools   Outline: :FlutterOutlineToggle
-- Devices:    :FlutterDevices
--
-- LSP is the dart language server shipped inside the Flutter SDK
-- (~/flutter/bin/cache/dart-sdk/bin/dart language-server) - no Mason needed.
-- flutter/dart are auto-detected from PATH (~/flutter/bin).
--
-- After enabling: :Lazy sync  then  :TSInstall dart

local dap, dapui = require "dap", require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end

return {
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
    opts = {
      lsp = {
        color = { enabled = true },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
        },
      },
      debugger = { -- uses nvim-dap + the dapui listeners above
        enabled = true,
        run_via_dap = true,
        register_configurations = function(_)
          require("dap").configurations.dart = {
            {
              type = "dart",
              request = "launch",
              name = "Launch Flutter (Chrome)",
              deviceId = "chrome",
            },
            {
              type = "dart",
              request = "launch",
              name = "Launch Flutter (Chrome, WASM)",
              deviceId = "chrome",
              args = { "--wasm" },
            },
          }
        end,
      },
      dev_log = { enabled = true, open_cmd = "botright 15split" },
      dev_tools = { autostart = false, auto_open_browser = false },
    },
  },
  -- dart treesitter parser (pack.dart is intentionally not used, so add it here)
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = { treesitter = { ensure_installed = { "dart" } } },
  },
}
