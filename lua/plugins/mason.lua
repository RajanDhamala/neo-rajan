return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    -- AstroCommunity packs auto-install LSPs
    -- Only add tools NOT covered by packs
    opts.ensure_installed = vim.tbl_extend("force", opts.ensure_installed or {}, {
      -- Formatters (not auto-installed by packs)
      "prettierd",
      "black",
      "gofumpt",
      "golines",
      -- Linters (not auto-installed by packs)
      "eslint_d",
      "ruff",
    })
    return opts
  end,
}
