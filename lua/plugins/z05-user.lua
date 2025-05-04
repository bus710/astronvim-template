return {
  -- Git
  { "tpope/vim-fugitive",
    cmd = "Git",
    lazy = false,
  },
  { 'rbong/vim-flog',
    cmd = "Flog"
  },
  --
  { "mfussenegger/nvim-dap" }, -- Debug adapter protocol
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  --
  { "othree/html5.vim" },
  { "pangloss/vim-javascript" },
  { "evanleck/vim-svelte", branch = "main" },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  {
    'alvan/vim-closetag'
  },
  --
  { "vim-erlang/vim-erlang-runtime" },
  { "vim-erlang/vim-erlang-compiler" },
  { "vim-erlang/vim-erlang-omnicomplete" },
  { "vim-erlang/vim-erlang-tags" },
  { "elixir-editors/vim-elixir" },
  --
  { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"}},
  --
  { "akinsho/flutter-tools.nvim" },
  --
  { "juliosueiras/vim-terraform-completion" }
}
