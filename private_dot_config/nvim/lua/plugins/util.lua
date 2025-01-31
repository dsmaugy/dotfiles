return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = {},
        },
      },
    },
  },
  { "ibhagwan/fzf-lua", opts = { files = { hidden = true }, grep = { hidden = true } } },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "ordinal",
        indicator = {
          style = "underline",
        },
      },
    },
    config = function(_, opts)
      local bufferline = require("bufferline")
      bufferline.setup(opts)
      for n = 1, 9 do
        vim.keymap.set("n", "g" .. n, function()
          bufferline.go_to(n, true)
        end, { desc = "[Bufferline] Go to " .. n .. "th buffer" })
      end
    end,
  },
}
