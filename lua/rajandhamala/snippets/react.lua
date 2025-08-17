-- ~/.config/nvim/lua/snippets/react.lua

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

-- Helper: get current filename without extension (capitalize first letter)
local function filename(_, _)
  local name = vim.fn.expand("%:t:r")
  return name:gsub("^%l", string.upper)
end

-- Make javascriptreact snippets available in typescriptreact
ls.filetype_extend("typescriptreact", { "javascriptreact" })

-- Snippets for React
ls.add_snippets("javascriptreact", {
  s("rfce", {
    t("import React from 'react'\n\n"),
    t("export default function "), f(filename, {}), t({"() {", "  return ("}),
    t({"", "    <div>"}), f(filename, {}), t({"</div>", "  )", "}"})
  }),
})
