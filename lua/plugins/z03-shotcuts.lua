-- https://docs.astronvim.com/recipes/mappings/

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode - n is the normal mode
        n = {
          gn = {
            function()
              -- vim.keymap.set(
              --   "n",
              --   "gn",
              --   function()
              --     vim.diagnostic.enable(not vim.diagnostic.is_enabled())
              --   end)
                vim.diagnostic.enable(not vim.diagnostic.is_enabled())
            end,
            desc = "Disable vim diagnostic info",
          },
          ga = {
            function()
              vim.cmd("Cscope db add /home/bus710/repo/module-test/linux/cscope.out")
              vim.cmd("set tags=/home/bus710/repo/module-test/linux/tags")
            end,
            desc = "Add kernel symbol files",
          },
        },
      },
    },
  },
}
