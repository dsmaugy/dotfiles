-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.linebreak = true
vim.opt.wrap = true
vim.opt.mouse = ""

vim.fn.setenv("GOFUMPT_SPLIT_LONG_LINES", "on")

vim.g.lazyvim_python_lsp = "pyright"
vim.g.root_spec = { { ".git" }, "lsp", { "lua" }, "cwd" }
