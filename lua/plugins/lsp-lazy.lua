return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    -- Lazy-load TypeScript LSP
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
      callback = function()
        vim.defer_fn(function()
          vim.cmd("LspStart tsserver")
        end, 100)
      end,
    })

    -- Lazy-load Python LSP
    vim.api. nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        vim.defer_fn(function()
          vim.cmd("LspStart pyright")
        end, 100)
      end,
    })

    -- Lazy-load Go LSP
    vim.api. nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.defer_fn(function()
          vim.cmd("LspStart gopls")
        end, 100)
      end,
    })

    return opts
  end,
}
