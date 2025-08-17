 -- init.lua

-- Bootstrap Lazy.nvim first
require("rajandhamala.lazy")

-- Load core settings
require("rajandhamala.core.settings")
require("rajandhamala.core.keymaps")
require("rajandhamala.clipboard")
require("rajandhamala.lsp")
require("rajandhamala.cmp")
-- Telescope setup
require("telescope").setup{
  defaults = {
    file_ignore_patterns = {"node_modules", ".git"},
    layout_strategy = "flex",
    sorting_strategy = "ascending",
  },
}
