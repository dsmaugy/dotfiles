return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
  opts = {
    adapters = {
      -- Hide all preset adapters so only the ACP ones below are listed
      http = {
        opts = { show_presets = false },
      },
      acp = {
        opts = { show_presets = false },
        -- Requires `npm i -g @agentclientprotocol/claude-agent-acp`
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            defaults = {
              mcpServers = "inherit_from_config",
              session_config_options = {
                mode = "auto",
              },
            },
          })
        end,
        -- Requires `npm i -g @agentclientprotocol/codex-acp`
        codex = function()
          return require("codecompanion.adapters").extend("codex", {
            defaults = {
              auth_method = "chat-gpt", -- "api-key" reads OPENAI_API_KEY instead
              mcpServers = "inherit_from_config",
            },
          })
        end,
        -- Requires the Cursor CLI (`agent`) and `agent login`
        cursor_cli = function()
          return require("codecompanion.adapters").extend("cursor_cli", {
            defaults = {
              mcpServers = "inherit_from_config",
            },
          })
        end,
      },
    },
    interactions = {
      chat = { adapter = "claude_code" },
    },
    display = {
      chat = {
        window = {
          layout = "vertical",
          position = "right",
          width = 0.35, -- matches claudecode's default split width
        },
      },
    },
  },
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Claude" },
    { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "New Claude chat" },
    {
      "<leader>ab",
      function()
        local path = vim.fn.expand("%:.")
        local cc = require("codecompanion")
        local chat = cc.last_chat()
        if not (chat and chat.ui:is_visible()) then
          cc.toggle_chat()
          chat = cc.last_chat()
        end
        local last = vim.api.nvim_buf_line_count(chat.bufnr)
        local line = vim.api.nvim_buf_get_lines(chat.bufnr, last - 1, last, false)[1]
        local sep = line == "" and "" or " "
        vim.api.nvim_buf_set_lines(chat.bufnr, last - 1, last, false, { line .. sep .. "#{buffer:" .. path .. "} " })
      end,
      desc = "Add current buffer",
    },
    { "<leader>as", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Send to Claude" },
  },
}
