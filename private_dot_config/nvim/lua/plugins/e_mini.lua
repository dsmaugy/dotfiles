return {
  "echasnovski/mini.nvim",
  config = function()
    -- Terminal background matching
    require("mini.misc").setup_termbg_sync()

    require("mini.icons").setup({
      filetype = {
        gotmpl = { glyph = "󰴑", hl = "MiniIconsBlue" },
      },
    })
  end,
}
