vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true -- needed for colorschemes

-- Make <Space> behave normally in insert mode
vim.api.nvim_set_keymap("i", "<Space>", "<Space>", { noremap = true, silent = true })
