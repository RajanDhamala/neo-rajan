return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    -- Find Node.js (fallback to system node if not found)
    local node_path = vim.fn.exepath "node"
    if node_path == "" then
      node_path = vim.fn.expand "~/.nvm/versions/node/*/bin/node"
      if vim.fn.filereadable(node_path) == 0 then
        vim.notify("Node.js not found!  Copilot disabled.", vim.log.levels.ERROR)
        return
      end
    end
    vim.g.copilot_node_command = node_path

    require("copilot").setup {
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

    -- Helper for safe suggestion calls
    local function with_copilot(fn)
      return function()
        local ok, suggestion = pcall(require, "copilot.suggestion")
        if not ok then return end
        fn(suggestion)
      end
    end

    -- Insert mode keymaps
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("i", "<C-l>", with_copilot(function(s) s.accept() end), opts)
    map("i", "<C-j>", with_copilot(function(s) s.next() end), opts)
    map("i", "<C-k>", with_copilot(function(s) s.prev() end), opts)
    map("i", "<C-h>", with_copilot(function(s) s.dismiss() end), opts)

    -- Leader mappings
    map("n", "<leader>mt", function()
      local ok, suggestion = pcall(require, "copilot.suggestion")
      if not ok then return end

      if suggestion.is_visible() then
        suggestion.dismiss()
        vim.notify("Copilot OFF", vim.log.levels.INFO)
      else
        vim.notify("Copilot ON", vim.log.levels.INFO)
      end
    end, { desc = "Toggle Copilot" })

    map("n", "<leader>mp", "<Cmd>Copilot panel<CR>", { desc = "Copilot Panel" })
  end,
}
