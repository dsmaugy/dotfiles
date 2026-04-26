return {
  {
    "nvim-mini/mini.surround",
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
    "nvim-mini/mini.icons",
    opts = {
      filetype = {
        ["gotmpl.html"] = { glyph = "󰴑", hl = "MiniIconsBlue" },
      },
    },
  },
  {
    "nvim-mini/mini.misc",
    config = function()
      -- some weirdness on tmux
      -- require("mini.misc").setup_termbg_sync()
    end,
  },
}
