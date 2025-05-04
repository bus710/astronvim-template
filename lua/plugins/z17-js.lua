-- https://github.com/mxsdev/nvim-dap-vscode-js/issues/14#issuecomment-1514656823
-- https://miguelcrespo.co/posts/debugging-javascript-applications-with-neovim/

local lazy_dir = vim.fn.stdpath("data") .. "/lazy"

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "mxsdev/nvim-dap-vscode-js",
      opts = {
        debugger_path = string.format("%s/vscode-js-debug/", lazy_dir),
        adapters = { "pwa-node", "node-terminal", "pwa-chrome"}
      },
    },
    { "theHamsta/nvim-dap-virtual-text", config = true },
    { "rcarriga/nvim-dap-ui",            config = true },
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    }
  },
  config = function()
    local dap, dapui = require "dap", require "dapui"

    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        localRoot = vim.fn.getcwd(),
        remoteRoot = "/usr/src/app"
      },
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Start Chrome with \"localhost\"",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
      }
    }

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
  end,
}
