-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    if vim.b.ruff_formatting then
      return
    end

    vim.b.ruff_formatting = true
    LazyVim.lsp.action["source.organizeImports"]()
    vim.defer_fn(function()
      vim.cmd("silent! write")
      vim.b.ruff_formatting = false
    end, 80)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    for i, arg in ipairs(vim.v.argv) do
      vim.cmd('echom "Arg ' .. i .. ": " .. arg .. '"')
    end

    local path = vim.fn.fnamemodify(vim.v.argv[3], ":p:h")
    vim.cmd('echom "Changing directory to 3rd argument: ' .. path .. '"')
    vim.cmd("silent! cd " .. path)
  end,
})
