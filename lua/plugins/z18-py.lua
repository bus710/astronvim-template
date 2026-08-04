-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

--[[
Python DAP + syntax highlight, driven by uv.

Prerequisites (run once, see repo/headless/27_py.sh):
- curl -LsSf https://astral.sh/uv/install.sh | sh
- uv python install 3.12

Per project:
- uv init        # new project
- uv sync        # creates .venv and installs deps from pyproject.toml
- launch nvim from the project root so .venv is picked up

Syntax highlight + LSP (pyright/basedpyright, ruff) come from
`astrocommunity.pack.python` (enable it in z04-community.lua). This file
also ensures the python treesitter parser and overrides the DAP adapter so
debugpy is fetched/run through uv instead of Mason.

Usage:
- :lua require("dap").continue()   (or <leader>dc) to start
- debugpy is NOT installed per project; uv fetches it on demand.

If DAP misbehaves, check that nvim was launched from the project root:
- :lua print(vim.fn.getcwd())
- :LspInfo / :LspLog
]]--

-- Resolve the debuggee interpreter to the project's uv-managed .venv so the
-- program under debug can import its own dependencies. The debugpy adapter
-- itself is run separately through uv (see dap.adapters.python below).
local function venv_python()
  local venv = vim.fn.getcwd() .. "/.venv/bin/python"
  if vim.fn.executable(venv) == 1 then
    return venv
  end
  return "python3"
end

return {
  -- nvim-dap-python is provided by `astrocommunity.pack.python`; this spec
  -- merges into it and takes over `config` to wire uv + the project .venv.
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      -- Registers default configs + test helpers (<leader>dT etc). The path
      -- arg is irrelevant here because we override the adapter just below.
      require("dap-python").setup("python3", { include_configs = false })

      -- Run the debugpy adapter through uv. No need to install debugpy into
      -- each project venv; uv fetches/caches it on demand.
      dap.adapters.python = {
        type = "executable",
        command = "uv",
        args = { "run", "--with", "debugpy", "python", "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "uv: Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          pythonPath = venv_python,
        },
        {
          type = "python",
          request = "launch",
          name = "uv: Launch module",
          module = function()
            return vim.fn.input("Module: ")
          end,
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          pythonPath = venv_python,
        },
        {
          type = "python",
          request = "attach",
          name = "uv: Attach (localhost:5678)",
          connect = { host = "127.0.0.1", port = 5678 },
          pythonPath = venv_python,
        },
      }

      -- Auto-open/close dap-ui, matching z15-zig.lua / z16-rust.lua.
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end
    end,
  },

  -- Ensure the python treesitter parser for syntax highlighting.
  {
    "AstroNvim/astrocore",
    opts = {
      treesitter = {
        ensure_installed = { "python" },
      },
    },
  },
}
