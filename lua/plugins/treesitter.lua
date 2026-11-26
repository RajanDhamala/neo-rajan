-- AstroNvim v6 configures highlighting, indentation, and text objects through
-- AstroCore. nvim-treesitter itself is now only the parser installer.
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      -- The SQL parser can read $1 placeholders as the start of a multiline string.
      highlight = function(lang) return lang ~= "sql" end,
      indent = function(lang) return lang ~= "python" end,
      ensure_installed = {
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "python",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
    },
  },
}
