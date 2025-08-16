Neo-Rajan: Personal Neovim Configuration

Welcome to Neo-Rajan, my personal Neovim setup designed for a modern, efficient, and visually appealing development experience. This configuration emphasizes a clean UI, intuitive navigation, and a seamless workflow—ideal for developers seeking an IDE-like environment within Neovim.

⚙️ Features

Modern Dashboard: A sleek startup screen powered by alpha-nvim, featuring session management, recent files, and a personalized greeting.

Bufferline Tabs: Manage multiple files effortlessly with a tabline interface, enhancing navigation between open buffers.

IDE-Like Setup: Integrated features such as LSP support, autocompletion, syntax highlighting, and more, to provide a comprehensive development environment.

Lazy.nvim Plugin Management: Efficient and fast plugin loading with Lazy.nvim, ensuring a responsive Neovim experience.

📦 Installation

To set up Neo-Rajan:

Clone the Repository:

git clone https://github.com/RajanDhamala/neo-rajan ~/.config/nvim


Install Dependencies:

Ensure you have Neovim 0.8+ installed. Then, open Neovim and run:

:Lazy sync


This command will install all required plugins and dependencies.

Configure Terminal:

For optimal appearance, use a terminal that supports true color and icons. Nerd Fonts are recommended for proper icon rendering.

🧩 Key Features

LSP Support: Language Server Protocol integration for enhanced code intelligence.

Autocompletion: Powered by nvim-cmp and LuaSnip, offering context-aware suggestions.

Syntax Highlighting: nvim-treesitter provides advanced syntax parsing for multiple languages.

File Navigation: Easily navigate files and buffers with telescope.nvim.

Git Integration: Seamless Git operations within Neovim using gitsigns.nvim.

🧪 Customization

Feel free to modify the configuration to suit your preferences. Key customization points include:

Plugin Management: Adjust plugins in lua/rajandhamala/plugins.lua.

Keybindings: Modify key mappings in lua/rajandhamala/keymaps.lua.

UI Settings: Tweak UI elements like statusline and bufferline in lua/rajandhamala/ui.lua.

📸 Screenshots


The modern dashboard with session management and recent files.


Efficient buffer navigation with tabline interface.

📄 License

This configuration is open-source and available under the MIT License. Feel free to use, modify, and distribute it as per the terms of the license.
