-- https://www.reddit.com/r/AstroNvim/comments/1bu8dx6/astronvim_v4_single_file_conf/
--

return {
  { 'Mofiqul/dracula.nvim' },
  {
    "AstroNvim/astroui",
    opts = {
      colorscheme = "dracula",
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = {
          tabstop = 4,
          softtabstop = 4,
          -- colorcolumn = '80,120'
          colorcolumn = '120',
          -- textwidth = 100,
          wrap = true
        },
      },
    },
  },
}
