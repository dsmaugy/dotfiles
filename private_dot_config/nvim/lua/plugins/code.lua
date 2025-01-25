return {

  -- Markdown Setup
  { "iamcco/markdown-preview.nvim", enabled = "false" },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        theme = "light",
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
    keys = { { "<leader>cp", "<cmd>:PeekOpen<cr>", desc = "Markdown Preview", ft = "markdown" } },
  },

  -- LSP / Color Formatting / Linting
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = false,
              analyses = {
                -- this analyzer is deprecated now
                -- see https://go-review.googlesource.com/c/tools/+/590375
                fieldalignment = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "actionlint", "glsl_analyzer" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "glsl", "gotmpl" } },
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
      })

      -- THANK YOU KEVIN NGUYEN
      -- https://github.com/nvim-treesitter/nvim-treesitter/discussions/1917#discussioncomment-10714144
      vim.treesitter.query.add_directive("inject-go-tmpl!", function(_, _, bufnr, _, metadata)
        local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
        local _, _, ext, _ = string.find(fname, ".*%.(%a+)(%.%a+)")
        metadata["injection.language"] = ext
      end, {})
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "LazyFile",
    config = function(_, opts)
      -- Autocomplete HTML tags in html template files
      require("nvim-ts-autotag").setup({
        aliases = {
          ["gotmpl"] = "html",
        },
      })
    end,
  },

  -- Code Editing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    -- Disable mini pairs to use nvim-autopairs instead
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "gbprod/cutlass.nvim",
    opts = {
      registers = {
        delete = '"',
        change = '"',
      },
    },
  },
}
