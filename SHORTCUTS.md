# Neo-Rajan Key Shortcuts & Plugin Usage

## Tmux Navigation
- `<Ctrl-h>`: Move to the left tmux pane
- `<Ctrl-j>`: Move to the below tmux pane
- `<Ctrl-k>`: Move to the above tmux pane
- `<Ctrl-l>`: Move to the right tmux pane
- `<Ctrl-\>`: Move to last active tmux pane
- `<Ctrl-Space>`: Move to next tmux pane

## Git Integration (Gitsigns)
- `<leader>gb`: Toggle blame for current line
- `<leader>gs`: Stage hunk
- `<leader>gu`: Undo stage hunk
- `<leader>gr`: Reset hunk
- `<leader>gp`: Preview hunk
- `<leader>gd`: Diff this file
- `<leader>gq`: Set quickfix list to hunks

## File Explorer
- `<leader>ee`: Toggle file explorer (NvimTree)

## Buffer Navigation
- `<Right>`: Next buffer
- `<Left>`: Previous buffer
- `<leader>bd`: Close buffer

## Fuzzy Finding (Telescope)
- `<leader>ff`: Find file
- `<leader>fs`: Find word (live grep)

## Trouble (Diagnostics)
- `<leader>xx`: Toggle Trouble
- `<leader>xw`: Workspace diagnostics
- `<leader>xd`: Document diagnostics
- `<leader>xq`: Quickfix list
- `<leader>xl`: Location list
- `gR`: LSP references

## Insert Mode
- Statusline shows current mode (e.g., INSERT)

## Tmux Configuration
- `unbind C-b`: Unbind default prefix
- `set-option -g prefix C-a`: Set prefix to `Ctrl-a`
- `bind C-a send-prefix`: Bind `Ctrl-a` to send prefix

---
For more, see your plugin configs in `lua/rajandhamala/plugins.lua` and keymaps in `lua/rajandhamala/core/keymaps.lua`.
