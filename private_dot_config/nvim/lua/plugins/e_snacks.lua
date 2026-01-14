return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- show hidden files
        },
        files = {
          hidden = true,
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
      actions = {
        flash = function(picker)
          require("flash").jump({
            pattern = "",
            label = { after = { 0, 0 } },
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
      },
    },

    dashboard = {
      width = 80,
      sections = {
        {
          section = "terminal",
          cmd = "chafa ~/.config/nvim/mirror.jpg --format symbols --size 60x17 --stretch; sleep .01",
          height = 17,
          padding = 1,
        },
        {
          pane = 2,
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    scroll = { enabled = false },
  },
}
