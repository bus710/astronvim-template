--[[ 
Prerequisites:
- sudo apt install lldb
- rustup component add rust-analyzer

To start the dap-ui:
- :RustLsp debuggables

If the dap-ui doesn't start well, check the LSP log
- :LspInfo
- :LspLog
- :lua vim.lsp.buf.definition() on a token

If Mason keeps failing codelldb, delete the lock file with
- rm -rf $HOME/.local/share/nvim/mason/staging/codelldb.lock
]]--


local dap = require "dap"
local dapui = require "dapui"

function getcwdtail()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
end

-- Rustaceanvim will take care of this part
-- dap.adapters.codelldb = {
--
-- }

dap.configurations.rust = {
  {
    name = 'CodeLLDB: Launch Custom',
    type = 'codelldb',
    request = 'launch',
    program = "${workspaceFolder}/target/debug/" .. getcwdtail(),
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

dap.adapters.lldb = {
  type = "executable",
  command = vim.fn.exepath("lldb-dap"),
  name = "lldb"
}

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end

return {
  -- If RustAnalyzer crashes
  --   rustup component add rust-analyzer
  -- To launch the debugger
  --   :RustLsp debuggables
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    options = {}
  },
  { "Saecki/crates.nvim"},
}
