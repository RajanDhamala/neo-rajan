# 📝 Neo-Rajan: Personal Neovim Configuration

Minimal, modular, and modern Neovim setup powered by **Lua** & **Lazy.nvim**

---

## 🚀 Features
- Modular structure for easy customization
- Lazy.nvim for fast plugin management
- Telescope for fuzzy finding and navigation
- Custom clipboard integration
- Sensible keymaps & settings
- LSP, autocompletion, syntax highlighting, and Git integration
- LuaSnip for powerful snippets (including React `rfce`)
- Gitsigns for inline Git status and hunk actions
- Trouble.nvim for inline error and diagnostics navigation
- Tmux navigation with seamless pane movement
- Which-key for keybinding discovery
- Floating command line and message UI (Noice)

---

## 📁 Folder Structure
```text
├── init.lua
├── lazy-lock.json
├── README.md
├── SHORTCUTS.md
└── lua/
    └── rajandhamala/
        ├── clipboard.lua
        ├── lazy.lua
        ├── plugins.lua
        ├── cmp.lua
        └── core/
            ├── keymaps.lua
            └── settings.lua
        └── snippets/
            └── react.lua
```

---

## ⚡️ Quick Start
1. **Clone this repo:**
   ```sh
   git clone https://github.com/RajanDhamala/neo-rajan ~/.config/nvim
   ```
2. **Open Neovim:**
   ```sh
   nvim
   ```
3. **Plugins will auto-install on first launch.**

---

## 🛠️ Main Files
- `init.lua` — Entry point, loads modules and plugins
- `lua/rajandhamala/lazy.lua` — Lazy.nvim bootstrap
- `lua/rajandhamala/plugins.lua` — Plugin list
- `lua/rajandhamala/core/settings.lua` — Editor settings
- `lua/rajandhamala/core/keymaps.lua` — Key mappings
- `lua/rajandhamala/clipboard.lua` — Clipboard integration
- `lua/rajandhamala/cmp.lua` — Autocompletion config
- `lua/rajandhamala/snippets/react.lua` — React snippets

---

## 🧩 Customization
- **Plugin Management:** Edit `lua/rajandhamala/plugins.lua`
- **Keybindings:** Edit `lua/rajandhamala/core/keymaps.lua`
- **Settings:** Edit `lua/rajandhamala/core/settings.lua`
- **Snippets:** Edit or add to `lua/rajandhamala/snippets/react.lua` for React/JSX/TSX snippets
- **Git & Diagnostics:** Use Gitsigns and Trouble.nvim for Git and error navigation
- **Tmux:** Use `<C-h/j/k/l>` to move between Neovim and tmux panes
- **Which-key:** Press `<leader>` to see available keybindings
- **Noice:** Enjoy a floating command line and message UI

---

## 📄 License
This configuration is open-source and available under the MIT License. Feel free to use, modify, and distribute it as per the terms of the license.

---

For all shortcuts, see `SHORTCUTS.md`.

<sub>Made with ❤️ by Rajan Dhamala</sub>
