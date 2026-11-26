local collapsed_sql_errors = vim.api.nvim_create_namespace("postgres_lsp.collapsed_errors")
local error_severity = vim.diagnostic.severity.ERROR

local function configure_postgres_diagnostics(client, bufnr)
  local namespace = vim.lsp.diagnostic.get_namespace(client.id)
  local sign_handlers = require("astroui").config.status.sign_handlers
  local sign_namespace = ("nvim.%s.diagnostic.signs"):format(vim.diagnostic.get_namespace(namespace).name)

  sign_handlers[sign_namespace] = function(args)
    local highlight = args.sign.texthl
    if highlight ~= "DiagnosticSignError" or args.button ~= "l" or args.mods:find("%S") then
      local fallback = sign_handlers[highlight]
      if fallback then fallback(args) end
      return
    end

    local buf = vim.api.nvim_win_get_buf(args.mousepos.winid)
    local row = args.mousepos.line - 1
    vim.schedule(function()
      if not vim.api.nvim_buf_is_loaded(buf) or row >= vim.api.nvim_buf_line_count(buf) then return end
      local marks = vim.api.nvim_buf_get_extmarks(buf, collapsed_sql_errors, { row, 0 }, { row, -1 }, {})
      if #marks == 0 then
        vim.api.nvim_buf_set_extmark(buf, collapsed_sql_errors, row, 0, {
          end_row = row + 1,
          end_col = 0,
          invalidate = true,
          undo_restore = false,
        })
      else
        vim.api.nvim_buf_clear_namespace(buf, collapsed_sql_errors, row, row + 1)
      end
      vim.diagnostic.show(namespace, buf)
    end)
  end

  vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = function(_, buf)
      local opts = vim.diagnostic.config().virtual_text
      if type(opts) == "function" then opts = opts(namespace, buf) end
      if not opts then return false end
      local marks = vim.api.nvim_buf_get_extmarks(buf, collapsed_sql_errors, 0, -1, {})
      if #marks == 0 then return opts end

      local collapsed_rows = {}
      for _, mark in ipairs(marks) do
        collapsed_rows[mark[2]] = true
      end
      opts = type(opts) == "table" and opts or {}
      local format = opts.format
      opts.format = function(diagnostic)
        if diagnostic.severity == error_severity and collapsed_rows[diagnostic.lnum] then return nil end
        if format then return format(diagnostic) end
        return diagnostic.message
      end
      return opts
    end,
  }, namespace)

  local group = vim.api.nvim_create_augroup("PostgresErrorToggle", { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = group,
    buffer = bufnr,
    callback = function()
      local marks = vim.api.nvim_buf_get_extmarks(bufnr, collapsed_sql_errors, 0, -1, {})
      if #marks == 0 then return end
      local error_rows = {}
      for _, diagnostic in ipairs(vim.diagnostic.get(bufnr, { namespace = namespace, severity = error_severity })) do
        error_rows[diagnostic.lnum] = true
      end
      for _, mark in ipairs(marks) do
        if not error_rows[mark[2]] then vim.api.nvim_buf_del_extmark(bufnr, collapsed_sql_errors, mark[1]) end
      end
    end,
  })
end

return {
  "AstroNvim/astrolsp",
  opts = function(_, opts)
    opts.mappings.n["<Leader>lg"] = {
      "<Cmd>checktime | lsp restart gopls<CR>",
      desc = "Refresh Go completions",
      cond = function(client) return client.name == "gopls" end,
    }

    opts.servers = require("astrocore").list_insert_unique(opts.servers or {}, {
      "bashls",
      "clangd",
      "cssls",
      "docker_compose_language_service",
      "dockerls",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "postgres_lsp",
      "pyright",
      "rust_analyzer",
      "tailwindcss",
      "ts_ls",
      "yamlls",
    })

    local format_on_save = opts.formatting.format_on_save
    format_on_save.ignore_filetypes =
      require("astrocore").list_insert_unique(format_on_save.ignore_filetypes or {}, { "sql" })

    opts.config = vim.tbl_deep_extend("force", opts.config or {}, {
      postgres_lsp = {
        root_dir = function(bufnr, on_dir)
          local markers = { "sqlc.yaml", "sqlc.yml", "sqlc.json", ".git" }
          local path = vim.api.nvim_buf_get_name(bufnr)
          if path ~= "" then on_dir(vim.fs.root(bufnr, markers) or vim.fs.dirname(path)) end
        end,
        cmd_env = {
          PGLS_CONFIG_PATH = vim.fn.stdpath "config" .. "/postgres-language-server.jsonc",
        },
        on_attach = configure_postgres_diagnostics,
      },

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
      clangd = {},
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
