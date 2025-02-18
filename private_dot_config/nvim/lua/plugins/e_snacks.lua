return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- show hidden files
        },
      },

      win = {
        input = {
          keys = {
            ["<c-t>"] = {
              "trouble_open",
              mode = { "n", "i" },
            },
          },
        },
      },
    },

    scroll = { enabled = false },
  },
}
