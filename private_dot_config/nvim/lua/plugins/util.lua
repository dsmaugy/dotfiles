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
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = false,
          },
        },
      })

      -- then load the extension
      telescope.load_extension("live_grep_args")
      vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    end,
  },
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
      -- vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { underline = "#ff0000", fg = "#ff0000" })
      for n = 1, 9 do
        vim.keymap.set("n", "g" .. n, function()
          bufferline.go_to(n, true)
        end, { desc = "[Bufferline] Go to " .. n .. "th buffer" })
      end

      -- vim.keymap.set("n", "<leader>bg", function()
      --   vim.ui.input({ prompt = "Enter buffer ID: " }, function(input)
      --     local buf_pos = tonumber(input)
      --     if buf_pos then
      --       bufferline.go_to(buf_pos, true)
      --     else
      --       print("Invalid buffer num!")
      --     end
      --   end)
      -- end, { noremap = true, silent = true })
    end,
  },
}
