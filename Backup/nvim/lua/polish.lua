-- Load custom keybindings
require("keybindings.keystroke").setup()

-- Custom polish (runs after everything loads)
vim.api.nvim_create_autocmd("User", {
  pattern = "AstroFile",
  callback = function()
    -- Your custom autocommands here (if needed)
  end,
})
