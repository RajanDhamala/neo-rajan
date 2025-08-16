-- clipboard.lua
-- Place this in your ~/.config/nvim/lua/core/ or similar

local M = {}

-- Check for xclip
local handle = io.popen("which xclip")
local result = handle:read("*a")
handle:close()

if result == "" then
  vim.notify("xclip not found! Clipboard integration won't work.", vim.log.levels.WARN)
  return
end

-- Use system clipboard for all yank, delete, change operations
vim.opt.clipboard = "unnamedplus"

-- Optional keymaps for convenience
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>y", [["+y]], opts)  -- yank to system clipboard
vim.keymap.set("v", "<leader>y", [["+y]], opts)  -- visual mode yank
vim.keymap.set("n", "<leader>p", [["+p]], opts)  -- paste from system clipboard
vim.keymap.set("v", "<leader>p", [["+p]], opts)

vim.notify("System clipboard (xclip) integrated successfully!", vim.log.levels.INFO)

return M
