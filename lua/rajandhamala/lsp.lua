local lspconfig = require("lspconfig")

-- list of LSP servers you want
local servers = {
  "sumneko_lua",  -- Lua
  "pyright",      -- Python
  "bashls",       -- Bash
  "clangd",       -- C/C++
  "tsserver",     -- JavaScript / TypeScript / Express
  "html",         -- HTML
  "cssls",        -- CSS
  "tailwindcss",  -- TailwindCSS
}

-- common setup for all servers
for _, server in ipairs(servers) do
  lspconfig[server].setup({
    on_attach = function(client, bufnr)
      -- optional: keymaps or other things per buffer
    end,
    settings = server == "sumneko_lua" and {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      }
    } or nil
  })
end
