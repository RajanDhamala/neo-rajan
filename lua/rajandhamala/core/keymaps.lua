-- keymaps.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true }

-- Basic saving and quitting
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>Q", ":qa!<CR>", opts)

-- File tree toggle
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Terminal toggle (bottom, 12 lines)
require("toggleterm").setup({
  open_mapping = [[<leader>t]],
  direction = "horizontal",
  size = 12,
  start_in_insert = true,
  persist_size = true,
})
vim.api.nvim_set_keymap("n", "<leader>t", ":ToggleTerm<CR>", opts)

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)


-- Buffers (multiple files)
vim.api.nvim_set_keymap("n", "<leader>bn", ":bnext<CR>", opts)     -- next buffer
vim.api.nvim_set_keymap("n", "<leader>bp", ":bprevious<CR>", opts) -- previous buffer
vim.api.nvim_set_keymap("n", "<leader>bd", ":bdelete<CR>", opts)   -- close buffer

-- Tabs
vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>tl", ":tabnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>th", ":tabprevious<CR>", opts)

-- Window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Move lines in visual mode
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- System clipboard copy/paste
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', opts) -- copy selection
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', opts) -- paste

-- Quick search & replace
vim.api.nvim_set_keymap("n", "<leader>sr", ":%s/", opts)

-- Toggle relative number
vim.api.nvim_set_keymap("n", "<leader>rn", ":set relativenumber!<CR>", opts)


-- Buffer navigation with arrow keys
vim.keymap.set("n", "<Right>", ":bnext<CR>", { noremap = true, silent = true })     -- right arrow → next buffer
vim.keymap.set("n", "<Left>", ":bprevious<CR>", { noremap = true, silent = true }) -- left arrow → prev buffer
