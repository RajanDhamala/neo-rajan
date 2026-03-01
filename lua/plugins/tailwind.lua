
-- plugins/tailwind.lua
return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {
      filetypes = {
        "css", "scss", "sass",
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "html", "astro",
      },
      user_default_options = {
        tailwind = true,
      },
    },
  },
}

