-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Belt-and-suspenders companion to after/plugin/stable_bg.vim.
--
-- Neovim 0.10+ keeps a TermResponse autocmd alive that updates 'background'
-- from OSC 11 terminal responses. defaults.lua deletes it at VimEnter only
-- when background was last set by a non-Lua script (last_set_sid ~= -8).
-- after/plugin/stable_bg.vim ensures that condition by setting background
-- from vimscript. This autocmd is an explicit fallback that nukes any
-- surviving OSC-11 listener after VimEnter, so cross-pane tmux responses
-- (allow-passthrough=on) cannot flip background and re-source the colorscheme.
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  desc = "Remove OSC-11 background auto-detect to prevent tmux cross-pane colorscheme flicker",
  callback = function()
    vim.schedule(function()
      for _, ac in ipairs(vim.api.nvim_get_autocmds({ event = "TermResponse" })) do
        if ac.desc and ac.desc:find("background", 1, true) then
          pcall(vim.api.nvim_del_autocmd, ac.id)
        end
      end
    end)
  end,
})

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
    end, 95)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- for i, arg in ipairs(vim.v.argv) do
    --   vim.cmd('echom "Arg ' .. i .. ": " .. arg .. '"')
    -- end

    local path = vim.fn.fnamemodify(vim.v.argv[3], ":p:h")
    -- vim.cmd('echom "Changing directory to 3rd argument: ' .. path .. '"')
    vim.cmd("silent! cd " .. path)
  end,
})
