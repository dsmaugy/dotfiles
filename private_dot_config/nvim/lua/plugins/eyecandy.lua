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
      mini.setup_termbg_sync()
    end,
  },
}
