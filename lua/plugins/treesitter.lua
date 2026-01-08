-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- Specify the main branch
  commit = "2ba5ec184609a96b513bf4c53a20512d64e27f39", -- https://github.com/nvim-treesitter/nvim-treesitter/commit/2ba5ec184609a96b513bf4c53a20512d64e27f39
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },
  },
}


