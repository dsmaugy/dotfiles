-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(event)
    if vim.bo[event.buf].filetype == "markdown" then
      vim.keymap.set("n", "<leader>cP", require("peek").open, { buffer = buffer, desc = "Open Markdown Preview" })
    end
  end,
})
