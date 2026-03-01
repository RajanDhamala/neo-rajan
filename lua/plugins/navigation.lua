---@type LazySpec
return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function(_, opts) require("harpoon").setup(opts) end,
    keys = {
      { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon add file" },
      { "<leader>hh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
      { "<leader>h1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon 1" },
      { "<leader>h2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon 2" },
      { "<leader>h3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon 3" },
      { "<leader>h4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon 4" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = vim.tbl_deep_extend("force", opts.filesystem.filtered_items or {}, {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
      })
      return opts
    end,
  },
}
