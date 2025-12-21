# Neovim Custom Keybindings Reference

This document contains all custom keybindings configured in this Neovim setup.

**Leaders:**
- `<leader>` = `Space`
- `<localleader>` = `,`

---

## Core Keybindings

### General Navigation & Editing
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<Esc>` | Normal | `:nohlsearch` | Clear search highlight |
| `<leader>a` | Normal | `ggVG` | Select all text |
| `<leader>P` | Normal | `vipgqq` | Format current paragraph |
| `<leader>s` | Normal | `:setlocal spell!` | Toggle spellcheck |
| `<leader>y` | Normal/Visual | `"+y` | Yank to system clipboard |
| `<leader>p` | Normal/Visual | `"+p` | Paste from system clipboard |
| `<leader>l` | Normal | - | Toggle list characters (tabs, EOL, etc.) |
| `<leader>o` | Normal | - | Toggle cursor column highlight |

### Window Management
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-h>` | Normal/Terminal/Visual | `<C-w>h` | Go to left window |
| `<C-j>` | Normal/Terminal/Visual | `<C-w>j` | Go to down window |
| `<C-k>` | Normal/Terminal/Visual | `<C-w>k` | Go to up window |
| `<C-l>` | Normal/Terminal/Visual | `<C-w>l` | Go to right window |
| `<M-h>` | Normal | `:vertical resize -1` | Shrink window horizontally |
| `<M-l>` | Normal | `:vertical resize +1` | Expand window horizontally |
| `<M-j>` | Normal | `:resize -1` | Shrink window vertically |
| `<M-k>` | Normal | `:resize +1` | Expand window vertically |

### Terminal
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader><Esc>` | Terminal | `<C-\><C-n>` | Exit terminal insert mode |

### Tab Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>1-9` | Normal | `1-9gt` | Go to tab 1-9 |

---

## Buffer Management

### Core Buffer Operations
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>bd` | Normal | `:bdelete` | Delete current buffer |
| `<leader>ba` | Normal | `:%bdelete\|edit#` | Delete all buffers except current |

### BufferLine Plugin
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `[b` | Normal | `:BufferLineCyclePrev` | Previous buffer |
| `]b` | Normal | `:BufferLineCycleNext` | Next buffer |
| `<leader>bp` | Normal | `:BufferLineTogglePin` | Toggle buffer pin |
| `<leader>bP` | Normal | `:BufferLineGroupClose ungrouped` | Delete non-pinned buffers |
| `<leader>bo` | Normal | `:BufferLineCloseOthers` | Delete other buffers |
| `<leader>br` | Normal | `:BufferLineCloseRight` | Delete buffers to the right |
| `<leader>bl` | Normal | `:BufferLineCloseLeft` | Delete buffers to the left |

---

## File Management & Search

### File Explorer (nvim-tree)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `-` | Normal | `:NvimTreeFocus` | Open/focus file browser |

### Telescope (Fuzzy Finder)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ff` | Normal | `:Telescope find_files` | Find files |
| `<leader>fg` | Normal | `:Telescope live_grep` | Live grep |
| `<leader>fb` | Normal | `:Telescope buffers` | Find buffers |
| `<leader>fh` | Normal | `:Telescope help_tags` | Find help tags |

---

## LSP (Language Server Protocol)

### Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `gD` | Normal | `vim.lsp.buf.declaration` | Go to declaration |
| `gd` | Normal | `vim.lsp.buf.definition` | Go to definition |
| `gi` | Normal | `vim.lsp.buf.implementation` | Go to implementation |
| `gr` | Normal | `vim.lsp.buf.references` | Go to references |
| `K` | Normal | `vim.lsp.buf.hover` | Show hover documentation |
| `<C-s>` | Normal/Insert | `vim.lsp.buf.signature_help` | Show signature help |

### Code Actions
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>rn` | Normal | `vim.lsp.buf.rename` | Rename symbol |
| `<leader>ca` | Normal | `vim.lsp.buf.code_action` | Show code actions |
| `<leader>D` | Normal | `vim.lsp.buf.type_definition` | Go to type definition |

### Workspace
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>wa` | Normal | `vim.lsp.buf.add_workspace_folder` | Add workspace folder |
| `<leader>wr` | Normal | `vim.lsp.buf.remove_workspace_folder` | Remove workspace folder |
| `<leader>wl` | Normal | - | List workspace folders |

### Diagnostics
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `[d` | Normal | `vim.diagnostic.goto_prev` | Go to previous diagnostic |
| `]d` | Normal | `vim.diagnostic.goto_next` | Go to next diagnostic |

---

## Trouble (Diagnostics)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>xx` | Normal | `:Trouble diagnostics toggle` | Toggle diagnostics |
| `<leader>xX` | Normal | `:Trouble diagnostics toggle filter.buf=0` | Buffer diagnostics only |
| `<leader>cs` | Normal | `:Trouble symbols toggle` | Show symbols |
| `<leader>cl` | Normal | `:Trouble lsp toggle` | LSP definitions/references |
| `<leader>xl` | Normal | `:Trouble loclist toggle` | Location list |
| `<leader>xq` | Normal | `:Trouble qflist toggle` | Quickfix list |

---

## Git Integration

### GitSigns
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `]c` | Normal | - | Next git hunk |
| `[c` | Normal | - | Previous git hunk |
| `<leader>hs` | Normal/Visual | - | Stage hunk |
| `<leader>hr` | Normal/Visual | - | Reset hunk |
| `<leader>hS` | Normal | - | Stage buffer |
| `<leader>hu` | Normal | - | Undo stage hunk |
| `<leader>hR` | Normal | - | Reset buffer |
| `<leader>hp` | Normal | - | Preview hunk |
| `<leader>hb` | Normal | - | Blame line |
| `<leader>tb` | Normal | - | Toggle line blame |
| `<leader>hd` | Normal | - | Diff this |
| `<leader>hD` | Normal | - | Diff this ~ |
| `<leader>td` | Normal | - | Toggle deleted |
| `ih` | Object/Visual | - | Select hunk (text object) |

### Fugitive
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>gs` | Normal | `:Git` | Git status |
| `<leader>gd` | Normal | `:Gdiff` | Git diff |
| `<leader>gb` | Normal | `:Git blame` | Git blame |
| `<leader>gl` | Normal | `:Git log` | Git log |
| `<leader>gp` | Normal | `:Git push` | Git push |
| `<leader>gP` | Normal | `:Git pull` | Git pull |
| `<leader>gc` | Normal | `:Git commit` | Git commit |
| `<leader>ga` | Normal | `:Git add .` | Git add all |

### Git Conflict Resolution
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>gh` | Normal | `:diffget //2` | Get hunk from left (HEAD) |
| `<leader>gj` | Normal | `:diffget //3` | Get hunk from right (merge) |
| `<leader>gk` | Normal | `:Gdiffsplit!` | 3-way diff |

---

## AI Assistant (Claude Code)

### Core Claude Code Commands
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>cc` | Normal | `:ClaudeCode` | Toggle Claude Code |
| `<C-,>` | Normal/Terminal | - | Toggle Claude Code window |
| `<leader>cn` | Normal | - | New Claude conversation |
| `<leader>cb` | Normal | - | Send buffer to Claude |
| `<leader>cj` | Normal | - | Continue Claude conversation |
| `<leader>cx` | Normal | - | Quit Claude session |
| `<leader>ch` | Normal | - | Claude help |
| `<leader>cr` | Normal | - | Resume Claude session |

### Advanced Claude Code Workflows
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>cv` | Visual | - | Send visual selection to Claude |
| `<leader>ce` | Normal | - | Explain current file with Claude |
| `<leader>cd` | Normal | - | Debug/review code with Claude |
| `<leader>cT` | Normal | - | Generate tests with Claude |

### Legacy Keybindings
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>cC` | Normal | - | Continue with Claude Code |
| `<leader>cV` | Normal | - | Verbose mode Claude Code |

---

## Completion (nvim-cmp)

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-Space>` | Insert | - | Trigger completion |
| `<C-n>` | Insert | - | Next completion item / Expand snippet |
| `<C-p>` | Insert | - | Previous completion item / Jump snippet backward |

---

## TreeSitter Text Objects

### Selection
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `af` | Visual/Object | - | Select outer function |
| `if` | Visual/Object | - | Select inner function |
| `ac` | Visual/Object | - | Select outer class |
| `ic` | Visual/Object | - | Select inner class |

### Navigation
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>vs` | Normal | - | Select entire scope (TreeSitter) |

---

## Special Commands

### Neovide (GUI) Specific
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<C-=>` | Normal | - | Increase font size |
| `<C-->` | Normal | - | Decrease font size |

### Utility Commands
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<leader>ds` | Normal | `:DeleteSwap` | Delete swap file for current buffer |
| `<F12>` | Normal | `:Inspect` | Show TreeSitter/highlight info at cursor |
| `<localleader>tw` | Normal | - | Toggle typewriter mode |

### Language-Specific (VimTeX)
| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<localleader>lv` | Normal | - | View PDF |
| `<localleader>lt` | Normal | `:VimtexTocToggle` | Toggle table of contents |

---

## Notes

- Many plugin keybindings are context-sensitive and only active when the relevant plugin/feature is loaded
- LSP keybindings are only active in buffers with an attached language server
- Git keybindings require the buffer to be in a git repository
- TreeSitter text objects require TreeSitter to be active for the current filetype
- Some keybindings may have additional variants or parameters not shown in this reference

For the most up-to-date keybindings, consult the configuration files directly:
- `lua/config/keymaps.lua` - Core keybindings
- `lua/plugins/*.lua` - Plugin-specific keybindings
