-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

for n = 1, 9 do
  vim.keymap.set("n", "g" .. n, function()
    require("bufferline").go_to(n, true)
  end, { desc = "[Bufferline] Go to " .. n .. "th buffer" })
end

-- vim.keymap.del({ "n", "t" }, "<C-m>")
vim.keymap.set({ "n", "t" }, "<C-n>", function()
  Snacks.terminal(nil, {
    win = {
      position = "float",
      relative = "editor",
      width = 0,
      height = 0,
      border = "rounded",
    },
  })
end, { desc = "Toggle fullscreen terminal" })
