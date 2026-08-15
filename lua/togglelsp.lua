local M = {}

local servers = {
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
}

local panel_win

local function close_panel()
  if panel_win and vim.api.nvim_win_is_valid(panel_win) then vim.api.nvim_win_close(panel_win, true) end
  panel_win = nil
end

function M.toggle_lsp(name)
  local enable = not vim.lsp.is_enabled(name)
  vim.lsp.enable(name, enable)
  if enable then
    -- Re-run FileType handlers so a server reattaches to the buffer that is
    -- already open instead of waiting for the next file to be entered.
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].buftype == "" and vim.bo[bufnr].filetype ~= "" then
      vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr, modeline = false })
    end
  end
  vim.notify(
    ("%s LSP: %s"):format(enable and "Enabled" or "Disabled and stopped", name),
    vim.log.levels.INFO
  )
end

function M.show_panel()
  close_panel()

  local active = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    active[client.name] = true
  end

  local lines = {}
  for _, name in ipairs(servers) do
    local status = active[name] and "[RUNNING]" or (vim.lsp.is_enabled(name) and "[ENABLED]" or "[OFF]")
    lines[#lines + 1] = ("%-9s %s"):format(status, name)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local width = 48
  panel_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = #lines,
    col = math.max(0, math.floor((vim.o.columns - width) / 2)),
    row = math.max(0, math.floor((vim.o.lines - #lines) / 2)),
    style = "minimal",
    border = "rounded",
    title = " LSP servers ",
    title_pos = "center",
  })

  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "lsp-toggle"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  for index, line in ipairs(lines) do
    local highlight = line:find("^%[RUNNING%]") and "DiagnosticOk"
      or (line:find("^%[ENABLED%]") and "DiagnosticInfo" or "Comment")
    vim.api.nvim_buf_add_highlight(buf, -1, highlight, index - 1, 0, 9)
  end

  vim.keymap.set("n", "<CR>", function()
    local selected = servers[vim.api.nvim_win_get_cursor(0)[1]]
    if selected then
      M.toggle_lsp(selected)
      vim.schedule(M.show_panel)
    end
  end, { buffer = buf, nowait = true, silent = true, desc = "Toggle selected LSP" })

  vim.keymap.set("n", "q", close_panel, {
    buffer = buf,
    nowait = true,
    silent = true,
    desc = "Close LSP panel",
  })
end

return M
