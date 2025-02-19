return {
  "akinsho/git-conflict.nvim",
  version = "*",
  lazy = false,
  opts = {
    default_mappings = {
      ours = "<leader>go",
      theirs = "<leader>gt",
      none = "<leader>g0",
      both = "<leader>g2",
      next = "]x",
      prev = "[x",
    },
  },
  keys = {
    {
      "<leader>gx",
      "<cmd>GitConflictListQf<cr>",
      desc = "List Conflicts",
    },
    {
      "<leader>gr",
      "<cmd>GitConflictRefresh<cr>",
      desc = "Refresh Conflicts",
    },
  },
}
