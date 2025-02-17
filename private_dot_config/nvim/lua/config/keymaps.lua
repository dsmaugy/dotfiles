-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

for n = 1, 9 do
  vim.keymap.set("n", "g" .. n, function()
    require("bufferline").go_to(n, true)
  end, { desc = "[Bufferline] Go to " .. n .. "th buffer" })
end
