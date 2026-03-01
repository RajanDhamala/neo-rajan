local m = {}

function m.setup()
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- ===============================
  -- General keybindings
  -- ===============================
  map("n", "<leader>bd", ":bdelete<CR>", opts)

  -- Move cursor to END/START of the line in insert mode
  map("n", "<A-e>", "A", opts)
  map("n", "<A-f>", "I", opts)

  -- Change buffer to the previous/next
  map("n", "<A-Left>", ":bprevious<CR>", opts)
  map("n", "<A-Right>", ":bnext<CR>", opts)

  map("i", "<A-Left>", "<Esc><Cmd>bprevious<CR>i", opts)
  map("i", "<A-Right>", "<Esc><Cmd>bnext<CR>i", opts)

  -- Move selected block UP/DOWN (like VS Code Alt+Up/Down)
  map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
  map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

  map("n", "<A-a>", "ggVG", opts)
  -- your select all code

  -- Select all lines in buffer
  -- map("n", "<A-a>", function()
  --   local bufnr = 0
  --   local last_line = vim.api.nvim_buf_line_count(bufnr)
  --   vim.api.nvim_buf_set_mark(bufnr, '<', 1, 0, {})
  --   vim.api.nvim_buf_set_mark(bufnr, '>', last_line, 0, {})
  --   vim.cmd('normal! gv')
  -- end, opts)
end

return m
