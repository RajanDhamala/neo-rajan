return {
  -- syntax helpers for JSX/TSX
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {
      filetypes = {
        "html",
        "javascript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "xml",
        "astro",
      },
    },
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)
    end,
  },
}
