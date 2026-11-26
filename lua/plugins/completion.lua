return {
  "saghen/blink.cmp",
  optional = true,
  opts = function(_, opts)
    -- The PostgreSQL server returns no suggestions with its connection disabled.
    opts.sources.per_filetype = opts.sources.per_filetype or {}
    opts.sources.per_filetype.sql = { "postgres", inherit_defaults = true }
    opts.sources.providers = opts.sources.providers or {}
    opts.sources.providers.postgres = {
      name = "PostgreSQL",
      module = "postgres_completion",
    }

    opts.keymap = opts.keymap or {}

    -- One context-aware Tab:
    --   1. Accept the selected LSP item when Blink's menu is visible.
    --   2. Otherwise accept visible Copilot ghost text.
    --   3. Otherwise keep normal snippet/Tab behavior.
    opts.keymap["<Tab>"] = {
      function(cmp)
        if cmp.is_visible() then return cmp.select_and_accept() end

        local ok, suggestion = pcall(require, "copilot.suggestion")
        if ok and suggestion.is_visible() then
          suggestion.accept()
          return true
        end
      end,
      "snippet_forward",
      "fallback",
    }

    opts.keymap["<Up>"] = { "select_prev", "fallback" }
    opts.keymap["<Down>"] = { "select_next", "fallback" }
  end,
}
