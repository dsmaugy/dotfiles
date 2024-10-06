return {

  -- Markdown Setup
  { "iamcco/markdown-preview.nvim", enabled = "false" },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        theme = "light",
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  -- LSP / Color Formatting / Linting
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "actionlint", "glsl_analyzer" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "glsl" } },
  },
}
