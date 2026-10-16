return {
  -- Paste clipboard images into the CodeCompanion chat
  -- need pngpaste on macos and wl-clipboard on linux
  "HakonHarnes/img-clip.nvim",
  cmd = "PasteImage",
  opts = {
    filetypes = {
      codecompanion = {
        dir_path = vim.fs.joinpath(vim.fn.stdpath("data"), "codecompanion", "images"),
        prompt_for_file_name = false,
        template = "[Image]($FILE_PATH)",
        use_absolute_path = true,
      },
    },
  },
  keys = {
    { "<leader>ap", "<cmd>PasteImage<cr>", desc = "Paste image" },
  },
}
