-- plugins.lua
return {
  -- Utility library
  { "nvim-lua/plenary.nvim" },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 30 },
        renderer = { icons = { show = { git = true, folder = true, file = true } } },
        filters = { dotfiles = false },
        actions = {
          open_file = {
            quit_on_open = false,
            resize_window = true,
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto", section_separators = "", component_separators = "" },
      })
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<leader>t]],
        direction = "horizontal",
        size = 15,
        start_in_insert = true,
        persist_size = true,
      })
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons" },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

-- Bufferline (like VS Code)
{
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers",                 -- show buffers like VS Code
        diagnostics = "nvim_lsp",         -- show LSP diagnostics on buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        separator_style = "slant",        -- slanted separators
        always_show_bufferline = true,
        numbers = "none",
      },
    })

    -- Navigate between buffers
    vim.keymap.set("n", "<Right>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<Left>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

    -- Close buffer with leader + bd
    vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { noremap = true, silent = true })
  end,
},

  -- Alpha-nvim greeter
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Header
dashboard.section.header.val = {
  "██████╗░░█████╗░░░░░░██╗░█████╗░███╗░░██░",
  "██╔══██╗██╔══██╗░░░░░██║██╔══██╗████╗░██║",
  "██████╔╝███████║░░░░░██║███████║██╔██╗ █║",
  "██╔══██╗██╔══██║██╗░░██║██╔══██║██║╚████║",
  "██║░░██║██║░░██║╚█████╔╝██║░░██║██║░╚███║",
  "╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚══╝",
}

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
        dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
        dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
        dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
      }

      -- Setup
      alpha.setup(dashboard.opts)
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
}
