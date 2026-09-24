-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          "zig", "go", "rs",
          "js", "javascript",
          "html","templ", "c",
          "ex", "heex", "gleam", "dart",
          -- "svelte", "js", "ts", "jsx", "tsx", "javascript", "typescript", "javascriptreact", "typescriptreact" 
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
      -- "exlixir",
      -- "tailwindcss",
      -- "html",
      -- "emmet_ls",
    },
    -- customize language server configuration passed to `vim.lsp.config`
    -- (client specific config can also live in `lsp/<server_name>.lua` in your config root; see `:h lsp-config`)
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      --
      --
      html = {
        cmd = { "vscode-html-language-server", "--stdio" },
        root_markers = {
          "tailwind.config.js",
          "package.json",
          "node_modules",
          ".git",
          "go.mod",
          "mix.exs",
          -- "tailwind.config.ts",
          -- "postcss.config.js",
          -- "postcss.config.ts",
        },
        filetypes = {
          "html", "templ", "go", "js", "javascript",
          "elixir", "eelixir", "heex", "ex", "gleam",
          -- "svelte", "javascript", "typescript", "javascriptreact", "typescriptreact",
        },
      },
      --
      --
      tailwindcss = {
        cmd = { "tailwindcss-language-server", "--stdio" },
        root_markers = {
          "tailwind.config.js",
          "package.json",
          "node_modules",
          ".git",
          "go.mod",
          "mix.exs",
          -- "tailwind.config.ts",
          -- "postcss.config.js",
          -- "postcss.config.ts",
        },
        filetypes = {
          "html", "templ", "go", "js", "javascript",
          "elixir", "eelixir", "heex", "ex", "gleam",
          -- "svelte", "javascript", "typescript", "javascriptreact", "typescriptreact",
        },
        -- Instead of having the init_options.includeLanguages/userLanguages, 
        -- add the includeLanguages under the settings.tailwindCSS.includeLanguages as the issue below suggests
        -- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/1002
        -- init_options = {
        --   includeLanguages = {
        --     -- elixir = "html-eex",
        --     -- eelixir = "html-eex",
        --     -- heex = "html-eex",
        --     html = "html",
        --     templ = "html",
        --   },
        --   userLanguages = {
        --     -- elixir = "html-eex",
        --     -- eelixir = "html-eex",
        --     -- heex = "html-eex",
        --     html = "html",
        --     templ = "html",
        --   },
        -- },
        settings = {
          tailwindCSS = {
            userLanguages = {
              go = "html",
              templ = "html",
            },
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
              gleam = "gleam",
              go = "html",
              templ = "html",
            },
            -- experimental = {
            --   -- Some css start with class:"" for majority of files
            --   -- Some css start with class("") for gleam/lustre
            --   classRegex = {
            --     'class[:]\\s*"([^"]*)"',
            --     'class[(]\\s*"([^"]*)"',
            --   },
            -- },
          },
        },
      },
      --
      --
      emmet_ls = {
        filetypes = {
          "html", "templ", "go", "js", "javascript",
          "elixir", "eelixir", "heex", "ex", "gleam",
          -- "svelte", "javascript", "typescript", "javascriptreact", "typescriptreact",
        },
      },
      --
      --
      htmx = {
        filetypes = {
          -- "html", "templ", "go", "js", "javascript"
          -- "elixir", "eelixir", "heex", "ex", "gleam",
          -- "svelte", "javascript", "typescript", "javascriptreact", "typescriptreact",
        },
      },
      c = {
        filetypes = {
          "zig", "c", "h",
        }
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- the `*` key modifies the default handler; it takes a single parameter, the server name
      -- ["*"] = function(server) vim.lsp.enable(server) end

      -- the key is the server that is being set up with `vim.lsp.config`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(server) vim.lsp.enable(server) end -- or a custom handler function can be passed

      -- zls = function(server)
      --   vim.lsp.config(server, {
      --     settings = {
      --       zls = {
      --         path = "/home/bus710/zig/zig",
      --         Zls = {
      --           path = "/home/bus710/zig/zls",
      --           enableAutofix = true,
      --           enable_snippets = true,
      --           enable_ast_check_diagnostics = true,
      --           enable_autofix = true,
      --           enable_import_embedfile_argument_completions = true,
      --           warn_style = true,
      --           enable_semantic_tokens = true,
      --           enable_inlay_hints = true,
      --           inlay_hints_hide_redundant_param_names = true,
      --           inlay_hints_hide_redundant_param_names_last_token = true,
      --           operator_completions = true,
      --           include_at_in_builtins = true,
      --           max_detail_length = 1048576,
      --         },
      --       },
      --     },
      --   })
      --   vim.lsp.enable(server)
      -- end,
      --
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client)
        --     return client:supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
        --   end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lsp-attach`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
