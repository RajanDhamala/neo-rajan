return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    -- LSP server-specific configurations
    -- opts.ensure_installed = { "tsserver", "pyright", "gopls" }  -- only LSPs you want
    opts.automatic_installation = false  --  disable auto-install completely
    opts.config = vim.tbl_deep_extend("force", opts.config or {}, {
      -- Python:  Optimized settings
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- Not "strict" (saves RAM)
              autoSearchPaths = false,
              useLibraryCodeForTypes = false,
              diagnosticMode = "openFilesOnly", -- Only check open files
            },
          },
        },
      },

      -- TypeScript: Memory-limited
      tsserver = {
        init_options = {
          maxTsServerMemory = 4096, -- Limit to 4GB
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "none",
              includeInlayFunctionParameterTypeHints = false,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "none",
              includeInlayFunctionParameterTypeHints = false,
            },
          },
        },
      },

      -- Go:  Reduced features
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = false, -- Disable expensive checks
              shadow = false,
            },
            staticcheck = false, -- Disable on-save checks
          },
        },
      },

      -- ESLint: Lightweight
      eslint = {
        settings = {
          workingDirectory = { mode = "auto" },
        },
      },

      -- Tailwind:  Only load when config exists
      tailwindcss = {
        root_dir = function(fname)
          local util = require("lspconfig.util")
          return util.root_pattern(
            "tailwind.config.js",
            "tailwind.config.ts",
            "tailwind.config.cjs"
          )(fname)
        end,
      },

      -- Lua: Keep default (already optimized)
      lua_ls = {},

      -- HTML/JSON/YAML: Lightweight
      html = {},
      jsonls = {},
      yamlls = {},

      -- Docker: Single LSP
      dockerls = {}
    })

    return opts
  end,
}
