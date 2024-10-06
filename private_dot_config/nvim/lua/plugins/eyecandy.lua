return {

  -- Set up colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "catppuccin-latte",
  } },

  -- Terminal background matching
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.misc").setup_termbg_sync()
    end,
  },
}
