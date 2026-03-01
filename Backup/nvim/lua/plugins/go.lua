---@type LazySpec
return {
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod", "gowork", "gosum" }, -- lazy-load only for Go
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      lsp_cfg = false,           -- let AstroNvim/astrolsp handle gopls config
      lsp_gofumpt = true,        -- use gofumpt formatting (matches your mason setup)
      lsp_on_attach = false,     -- use AstroNvim's on_attach
      lsp_keymaps = false,       -- we'll rely on Astro's keymaps
      trouble = false,
      lsp_codelens = true,
      lsp_diag_hdlr = true,
      test_runner = "go",        -- or "gotests", "richgo"
      run_in_floaterm = true,
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
  },
}