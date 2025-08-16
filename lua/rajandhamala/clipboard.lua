-- ~/.config/nvim/lua/core/clipboard.lua
local M = {}

-- Make sure xclip is available
local handle = io.popen("which xclip")
local result = handle:read("*a")
handle:close()

if result == "" then
  vim.notify("xclip not found! Clipboard integration won't work.", vim.log.levels.WARN)
  return
end

-- Disable default unnamedplus so deletes stay local
vim.opt.clipboard = ""

local opts = { noremap = true, silent = true }

-- Map yanks to system clipboard automatically
vim.keymap.set("n", "y", [["+y]], opts)
vim.keymap.set("n", "Y", [["+Y]], opts)
vim.keymap.set("v", "y", [["+y]], opts)

-- Map pastes from system clipboard automatically
vim.keymap.set("n", "p", [["+p]], opts)
vim.keymap.set("n", "P", [["+P]], opts)
vim.keymap.set("v", "p", [["+p]], opts)
vim.keymap.set("v", "P", [["+P]], opts)

-- Deletes remain normal (local) register
-- dd, d, c are untouched

vim.notify("Yank/paste now use system clipboard; deletes stay local.", vim.log.levels.INFO)

return M
