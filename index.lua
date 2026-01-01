
-- /root/.config/nvim/init.lua

-- BASIC OPTIONS
local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.foldmethod = "manual"

-- PLUGINS (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({ check_ts = false })
    end
  },
  -- Telescope for fuzzy search
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  }
})

-- FILE EXPLORER TOGGLE
vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ":lua ToggleNetrw()<CR>",
  { noremap = true, silent = true }
)

function ToggleNetrw()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "netrw" then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  vim.cmd("Vexplore")
end

-- BUFFER NAVIGATION (Alt+Left / Alt+Right)
vim.api.nvim_set_keymap("n", "<A-Right>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Left>",  ":bprevious<CR>", { noremap = true, silent = true })

-- TELESCOPE KEYMAPS
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
