-- Spinner in the statusline + inline virtual text while a CodeCompanion request is in flight
local active = {} -- key ("chat:<id>" or "req:<id>") -> { text = string, bufnr = number? }
local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local timer = nil

-- Claude Code's spinnerVerbs, copied from ~/.claude/settings.json
local verbs = nil

local function random_verb()
  if not verbs then
    local ok, data = pcall(function()
      local path = vim.fs.joinpath(vim.fn.stdpath("config"), "data", "claude-spinner-verbs.json")
      return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
    end)
    verbs = ok and vim.tbl_get(data, "spinnerVerbs", "verbs") or {}
  end
  if #verbs == 0 then
    return "Thinking"
  end
  return verbs[vim.uv.hrtime() % #verbs + 1]
end

local function codecompanion_status()
  local _, entry = next(active)
  if not entry then
    return ""
  end
  local frame = spinner[math.floor(vim.uv.hrtime() / 1e8) % #spinner + 1]
  return frame .. " " .. entry.text
end

local function on_request(ev)
  local data = ev.data or {}
  if not data.id then
    return
  end

  if ev.match == "CodeCompanionChatSubmitted" then
    local ok, chat = pcall(function()
      return require("codecompanion").buf_get_chat(data.bufnr)
    end)
    local name = (ok and chat and chat.adapter and chat.adapter.formatted_name) or "AI"
    local verb = random_verb() .. "…"
    active["chat:" .. data.id] = { text = name .. ": " .. verb, bufnr = data.bufnr }
    if ok and chat and chat._set_status then
      pcall(chat._set_status, chat, "thinking", "  " .. verb)
    end
  elseif ev.match == "CodeCompanionRequestStarted" then
    -- If this request belongs to a chat that already registered on ChatSubmitted, keep that entry
    for _, entry in pairs(active) do
      if data.bufnr and entry.bufnr == data.bufnr then
        return
      end
    end
    local name = (data.adapter and data.adapter.formatted_name) or "AI"
    active["req:" .. data.id] = { text = name .. ": " .. random_verb() .. "…", bufnr = data.bufnr }
  elseif ev.match == "CodeCompanionRequestFinished" then
    active["req:" .. data.id] = nil
    if data.bufnr then
      for k, entry in pairs(active) do
        if entry.bufnr == data.bufnr then
          active[k] = nil
        end
      end
    end
  else
    -- ChatDone / ChatStopped / ChatClosed / ChatRestored
    active["chat:" .. data.id] = nil
    if data.bufnr then
      for k, entry in pairs(active) do
        if entry.bufnr == data.bufnr then
          active[k] = nil
        end
      end
    end
  end

  if next(active) and not timer then
    timer = vim.uv.new_timer()
    timer:start(
      0,
      100,
      vim.schedule_wrap(function()
        require("lualine").refresh({ place = { "statusline" } })
      end)
    )
  elseif not next(active) and timer then
    timer:stop()
    timer:close()
    timer = nil
    require("lualine").refresh({ place = { "statusline" } })
  end
end

vim.api.nvim_create_autocmd("User", {
  pattern = {
    "CodeCompanionChatSubmitted",
    "CodeCompanionChatDone",
    "CodeCompanionChatStopped",
    "CodeCompanionChatClosed",
    "CodeCompanionChatRestored",
    "CodeCompanionRequestStarted",
    "CodeCompanionRequestFinished",
  },
  callback = on_request,
})

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, 1, {
      codecompanion_status,
      color = function()
        return { fg = Snacks.util.color("Special") }
      end,
    })
  end,
}
