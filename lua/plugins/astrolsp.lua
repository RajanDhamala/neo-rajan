return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    opts.servers = require("astrocore").list_insert_unique(opts.servers or {}, {
      "bashls",
      "cssls",
      "docker_compose_language_service",
      "dockerls",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "pyright",
      "tailwindcss",
      "ts_ls",
      "yamlls",
    })

    opts.config = vim.tbl_deep_extend("force", opts.config or {}, {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      },

      ts_ls = {
        init_options = {
          hostInfo = "neovim",
          maxTsServerMemory = 4096,
          preferences = {
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
            includePackageJsonAutoImports = "on",
            importModuleSpecifierPreference = "shortest",
          },
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

      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            analyses = {
              unusedparams = false,
              shadow = false,
            },
            staticcheck = false,
          },
        },
      },

      bashls = {},
      cssls = {},
      docker_compose_language_service = {},
      dockerls = {},
      html = {},
      jsonls = {},
      lua_ls = {},
      tailwindcss = {},
      yamlls = {
        filetypes = { "yaml", "yaml.ansible", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
        settings = {
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
          yaml = {
            validate = true,
            completion = true,
            hover = true,
            format = {
              enable = true,
            },
            schemaStore = {
              enable = true,
            },
            schemas = {
              kubernetes = {
                "k8s/**/*.yaml",
                "k8s/**/*.yml",
                "kubernetes/**/*.yaml",
                "kubernetes/**/*.yml",
                "manifests/**/*.yaml",
                "manifests/**/*.yml",
              },
            },
          },
        },
      },
    })

    return opts
  end,
}
