return {
  "zbirenbaum/copilot.lua",
  version = "^3",
  cmd = "Copilot",
  event = "InsertEnter",
  keys = { { "<leader>a", desc = "Toggle Copilot AI" } },
  config = function()
    -- Copilot requires Node.js 22+, so use the NVM-managed version directly.
    -- Shell functions created by lazy-loaded NVM are not inherited by Neovim.
    local node_path = vim.fn.expand "$HOME/.nvm/versions/node/v22.21.1/bin/node"
    if vim.fn.executable(node_path) ~= 1 then
      vim.notify("NVM Node.js 22 not found. Copilot is disabled.", vim.log.levels.ERROR)
      return
    end

    require("copilot").setup {
      copilot_node_command = node_path,
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      panel = { enabled = true },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
    }

    -- Never draw Copilot ghost text over Blink's LSP completion menu.
    local completion_group = vim.api.nvim_create_augroup("CopilotBlinkIntegration", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = completion_group,
      pattern = "BlinkCmpMenuOpen",
      callback = function() vim.b.copilot_suggestion_hidden = true end,
    })
    vim.api.nvim_create_autocmd("User", {
      group = completion_group,
      pattern = "BlinkCmpMenuClose",
      callback = function() vim.b.copilot_suggestion_hidden = false end,
    })

    -- Helper for safe suggestion calls
    local function with_copilot(fn)
      return function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if not ok then return end
        fn(suggestion)
      end
    end

    -- Simple insert mode keymap. Tab is coordinated with Blink separately.
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("i", "<C-l>", with_copilot(function(s) s.accept() end), opts)

    -- This is a process-level toggle. OFF tears down the plugin and force-stops
    -- any remaining Copilot LSP client so it cannot keep consuming resources.
    local function toggle_copilot()
      local client = require "copilot.client"
      local command = require "copilot.command"

      if client.is_disabled() then
        command.enable()
        vim.notify("Copilot ON — LSP process started", vim.log.levels.INFO)
      else
        local active_clients = vim.lsp.get_clients { name = "copilot" }
        command.disable()
        for _, active_client in ipairs(active_clients) do
          pcall(function() active_client:stop(true) end)
        end
        vim.notify("Copilot OFF — LSP process stopped", vim.log.levels.INFO)
      end
    end

    map("n", "<leader>a", toggle_copilot, { desc = "Toggle Copilot AI" })

    map("n", "<leader>mp", "<Cmd>Copilot panel<CR>", { desc = "Copilot Panel" })
  end,
}
