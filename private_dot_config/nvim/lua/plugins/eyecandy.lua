return {

  -- Set up colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "LazyVim/LazyVim", opts = {
    colorscheme = "catppuccin-latte",
  } },

  -- Mini Nvim Setup
  -- {
  --   "echasnovski/mini.nvim",
  --   config = function()
  --     -- Terminal background matching
  --     require("mini.misc").setup_termbg_sync()
  --
  --     require("mini.icons").setup({
  --       filetype = {
  --         gotmpl = { glyph = "󰴑", hl = "MiniIconsBlue" },
  --       },
  --     })
  --   end,
  -- },
}
