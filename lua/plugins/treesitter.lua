---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- latest
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" }, -- lazy-load on buffer open
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- optional
  },
  opts = {
    ensure_installed = { "lua", "python", "javascript", "typescript", "go", "json", "html", "css" }, -- customize
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        node_decremental = "grm",
        scope_incremental = "grc",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },
    playground = {
      enable = true, -- optional, for interactive Treesitter playground
      updatetime = 25,
      persist_queries = false,
    },
  },
  config = function(_, opts)
    local ts = require "nvim-treesitter.configs"
    ts.setup(opts)

    -- Lazy-load parsers only when buffer language is matched
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      callback = function()
        local ft = vim.bo.filetype
        local parsers = require("nvim-treesitter.parsers").available_parsers()
        if not vim.tbl_contains(parsers, ft) then return end
        pcall(vim.cmd, "TSBufEnable highlight")
      end,
    })
  end,
}
