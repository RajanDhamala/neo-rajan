local M = {}

-- Toggle LSP by name
function M.toggle_lsp(name)
  local clients = vim.lsp.get_clients { name = name }

  if #clients > 0 then
    -- Stop all instances of this LSP
    for _, client in ipairs(clients) do
      client.stop()
    end
    vim.notify("Stopped LSP: " .. name, vim.log.levels.INFO)
    return
  end

  -- Start LSP if not running
  local ok, lspconfig = pcall(require, "lspconfig")
  if not ok then
    vim.notify("lspconfig not found", vim.log.levels.ERROR)
    return
  end

  local config = lspconfig[name]
  if not config then
    vim.notify("LSP config not found: " .. name, vim.log.levels.ERROR)
    return
  end

  -- Attach to current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd("LspStart " .. name) -- More reliable than manual attach
  vim.notify("Started LSP: " .. name, vim.log.levels.INFO)
end

-- Show floating panel
function M.show_panel()
  -- Close previous window
  if vim.w.togglelsp_win and vim.api.nvim_win_is_valid(vim.w.togglelsp_win) then
    vim.api.nvim_win_close(vim.w.togglelsp_win, true)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local width = 50

  -- Get all configured LSPs
  local ok, lspconfig = pcall(require, "lspconfig")
  if not ok then
    vim.notify("lspconfig not available", vim.log.levels.ERROR)
    return
  end

  local configs = require "lspconfig.configs"
  local all_lsp_names = vim.tbl_keys(configs)
  table.sort(all_lsp_names)

  -- Get active clients
  local active_map = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    active_map[client.name] = true
  end

  -- Prepare lines
  local lines = {}
  for _, name in ipairs(all_lsp_names) do
    if active_map[name] then
      table.insert(lines, "[ACTIVE]   " .. name)
    else
      table.insert(lines, "[INACTIVE] " .. name)
    end
  end

  local height = math.min(#lines, 20) -- Max 20 rows
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  })

  vim.w.togglelsp_win = win
  vim.bo[buf].bufhidden = "wipe"

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  -- Syntax highlighting
  for i, name in ipairs(all_lsp_names) do
    if active_map[name] then
      vim.api.nvim_buf_add_highlight(buf, -1, "String", i - 1, 0, 10)
      vim.api.nvim_buf_add_highlight(buf, -1, "Identifier", i - 1, 11, -1)
    else
      vim.api.nvim_buf_add_highlight(buf, -1, "Comment", i - 1, 0, -1)
    end
  end

  -- Keybindings
  vim.keymap.set("n", "<CR>", function()
    local line = vim.api.nvim_win_get_cursor(win)[1]
    local lsp_name = all_lsp_names[line]
    if lsp_name then
      M.toggle_lsp(lsp_name)
      vim.defer_fn(function()
        M.show_panel() -- Refresh panel after toggle
      end, 100)
    end
  end, { buffer = buf, nowait = true })

  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end, { buffer = buf, nowait = true })
end

return M
