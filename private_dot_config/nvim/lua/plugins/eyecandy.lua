return {

  -- Set up colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "catppuccin-latte",
  } },

  -- Mini Nvim Setup
  {
    "echasnovski/mini.misc",
    config = function()
      -- Terminal background matching
      local mini = require("mini.misc")
      mini.setup()
    end,
  },

  { "snacks.nvim", opts = {
    scroll = { enabled = false },
  } },

  { "folke/which-key.nvim", opts = { preset = "modern" } },
}
