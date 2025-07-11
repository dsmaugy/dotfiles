return {
  "nvim-treesitter/nvim-treesitter",
  opts = { ensure_installed = { "glsl", "gotmpl", "java", "css" } },
  ---@param opts TSConfig
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)

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
