-- Resolve a GitHub token for gh_actions_ls. Prefers an explicit env var, then
-- falls back to whatever the `gh` CLI is logged in with.
local gh_token = nil
local function get_gh_token()
  if gh_token ~= nil then
    return gh_token ~= false and gh_token or nil
  end

  local env = vim.env.GITHUB_TOKEN or vim.env.GH_TOKEN
  if env and env ~= "" then
    gh_token = env
    return gh_token
  end

  if vim.fn.executable("gh") == 1 then
    local out = vim.system({ "gh", "auth", "token" }, { text = true }):wait(5000)
    if out.code == 0 and vim.trim(out.stdout or "") ~= "" then
      gh_token = vim.trim(out.stdout)
      return gh_token
    end
  end

  gh_token = false
  return nil
end

-- Repo context unlocks secrets/variables/environment/runner-label completion.
-- The server wants the numeric repo id, so this is one `gh api` call per repo root.
local repo_cache = {}
local function get_repo_context(dir)
  local root = vim.fs.root(dir, ".git")
  if not root then
    return nil
  end
  if repo_cache[root] ~= nil then
    return repo_cache[root] or nil
  end

  local repo = nil
  if vim.fn.executable("gh") == 1 then
    local out = vim
      .system({ "gh", "api", "repos/{owner}/{repo}", "--jq", "[.id, .owner.login, .name, .owner.type] | @tsv" }, {
        cwd = root,
        text = true,
      })
      :wait(5000)
    if out.code == 0 then
      local id, owner, name, owner_type = unpack(vim.split(vim.trim(out.stdout or ""), "\t"))
      if id and owner and name then
        repo = {
          id = tonumber(id),
          owner = owner,
          name = name,
          organizationOwned = owner_type == "Organization",
          workspaceUri = vim.uri_from_fname(root),
        }
      end
    end
  end

  repo_cache[root] = repo or false
  return repo
end

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
        ty = {
          enabled = true,
        },
        pyright = {
          enabled = false,
        },
        gh_actions_ls = {
          -- Resolved lazily so nothing shells out until a workflow file is opened.
          before_init = function(params, config)
            local init = params.initializationOptions or {}
            init.sessionToken = get_gh_token()

            local repo = get_repo_context(config.root_dir or vim.uv.cwd())
            if repo then
              init.repos = { repo }
            end

            params.initializationOptions = init
          end,
        },
      },
    },
  },
}
