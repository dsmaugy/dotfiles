return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  opts = { ensure_installed = { "glsl", "gotmpl", "java", "css" } },
  -- NOTE: don't override `config` here -- LazyVim's config is what calls
  -- `TS.setup()`, installs missing parsers and creates the FileType autocmd
  -- that runs `vim.treesitter.start()`. Put customizations in `init` instead.
  init = function()
    vim.filetype.add({
      extension = {
        gotmpl = "gotmpl",
        tmpl = "gotmpl",
      },
      pattern = {
        [".*%.html%.tmpl"] = function()
          return "gotmpl.html"
        end,
      },
    })

    -- THANK YOU KEVIN NGUYEN
    -- https://github.com/nvim-treesitter/nvim-treesitter/discussions/1917#discussioncomment-10714144
    vim.treesitter.query.add_directive("inject-go-tmpl!", function(_, _, bufnr, _, metadata)
      if type(bufnr) == "string" then
        return
      end
      local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
      local _, _, ext, _ = string.find(fname, ".*%.(%a+)(%.%a+)")
      metadata["injection.language"] = ext
    end, {})
  end,
}
