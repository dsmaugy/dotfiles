return {
  {
    "echasnovski/mini.surround",
    opts = {
      custom_surroundings = {
        ["("] = { output = { left = "(", right = ")" } },
        [")"] = { output = { left = "( ", right = " )" } },
        ["<"] = { output = { left = "<", right = ">" } },
        [">"] = { output = { left = "< ", right = " >" } },
        ["["] = { output = { left = "[", right = "]" } },
        ["]"] = { output = { left = "[ ", right = " ]" } },
        ["{"] = { output = { left = "{", right = "}" } },
        ["}"] = { output = { left = "{ ", right = " }" } },
      },
      mappings = {
        add = ";;",
        delete = ";d",
        find = ";f",
        find_left = ";F",
        highlight = ";h",
        replace = ";r",
        update_n_lines = ";n",
      },
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {
      filetype = {
        gotmpl = { glyph = "󰴑", hl = "MiniIconsBlue" },
      },
    },
  },
  {
    "echasnovski/mini.misc",
    config = function()
      require("mini.misc").setup_termbg_sync()
    end,
  },
}
