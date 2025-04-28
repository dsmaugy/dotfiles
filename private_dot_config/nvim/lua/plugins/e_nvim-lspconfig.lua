return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
            },
          },
        },
        html = {
          filetypes = { "html", "gotmpl.html" },
        },
        cssls = {},
      },
    },
  },
}
