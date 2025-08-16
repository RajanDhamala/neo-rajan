
<div align="center">
	<h1>📝 Neo-Rajan: Personal Neovim Configuration</h1>
	<p>Minimal, modular, and modern Neovim setup powered by <b>Lua</b> & <b>Lazy.nvim</b></p>
	<img src="https://neovim.io/logos/neovim-mark.svg" width="80" />
</div>

---

## 🚀 Features

- **Modular structure** for easy customization
- **Lazy.nvim** for fast plugin management
- **Telescope** for fuzzy finding and navigation
- Custom clipboard integration
- Sensible keymaps & settings
- LSP, autocompletion, syntax highlighting, and Git integration

---

## 📁 Folder Structure

```text
├── init.lua
├── lazy-lock.json
├── README.md
└── lua/
		└── rajandhamala/
				├── clipboard.lua
				├── lazy.lua
				├── plugins.lua
				└── core/
						├── keymaps.lua
						└── settings.lua
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

---

## 🧩 Customization

- **Plugin Management:** Edit `lua/rajandhamala/plugins.lua`
- **Keybindings:** Edit `lua/rajandhamala/core/keymaps.lua`
- **Settings:** Edit `lua/rajandhamala/core/settings.lua`

---

## � Useful Links

- [Neovim](https://neovim.io/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

---

## 📄 License

This configuration is open-source and available under the MIT License. Feel free to use, modify, and distribute it as per the terms of the license.

<div align="center">
	<sub>Made with ❤️ by Rajan Dhamala</sub>
</div>
