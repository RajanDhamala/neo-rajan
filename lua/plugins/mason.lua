return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed or {}, {
      "bash-language-server",
      "css-lsp",
      "docker-compose-language-service",
      "dockerfile-language-server",
      "gopls",
      "html-lsp",
      "json-lsp",
      "lua-language-server",
      "pyright",
      "tailwindcss-language-server",
      "tree-sitter-cli",
      "typescript-language-server",
      "yaml-language-server",
    })
    return opts
  end,
}
