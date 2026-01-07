# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

Neovim configuration using Lazy.nvim plugin manager with modular Lua-based structure.

### Configuration Loading Order
1. `init.lua` - Sets leader key (`\`), bootstraps Lazy.nvim, loads options and keymaps
2. `lua/options.lua` - Vim settings, autocommands for filetype detection
3. `lua/keymaps.lua` - Key mappings, Copilot configuration
4. `lua/plugins/init.lua` - Plugin specifications (imported by Lazy.nvim)
5. `lua/config/*.lua` - Plugin-specific configurations loaded on-demand

### Key Architectural Decisions

**Dual Completion System**: CoC.nvim is primary; nvim-cmp is configured as fallback (disabled when CoC is running via `vim.g.coc_enabled` check in `lua/config/nvim-cmp.lua`).

**Smart Tab Priority**: Tab key checks Copilot suggestions first, then CoC completion, then inserts literal tab (see `lua/config/coc.lua:13-24`).

**CocList Mappings Use Space Prefix**: While leader is backslash, space-prefixed mappings (`<space>a`, `<space>e`, etc.) provide quick access to CocList features (diagnostics, extensions, commands).

## Key Mappings Reference

| Mapping | Action | Context |
|---------|--------|---------|
| `\e` | Toggle NERDTree | Normal |
| `\rn` | Rename symbol | CoC |
| `\f` | Format selection | CoC |
| `\a` | Code action (selection) | CoC |
| `\ac` | Code action (buffer) | CoC |
| `\qf` | Quick fix current line | CoC |
| `gd/gy/gi/gr` | Definition/Type/Implementation/References | CoC |
| `K` | Show documentation | CoC |
| `[g/]g` | Previous/Next diagnostic | CoC |
| `<C-j>` | Accept Copilot suggestion | Insert |
| `<space>a/e/c/o/s` | CocList: diagnostics/extensions/commands/outline/symbols | Normal |

## Custom Commands

- `:Format` - Format current buffer
- `:Fold` - Fold current buffer
- `:OR` - Organize imports

## External Dependencies

- Node.js (required for CoC.nvim)
- ctags at `/opt/homebrew/bin/ctags` (for gutentags)
- Git (for vim-fugitive, vim-signify)

## Plugin Management

```vim
:Lazy sync    " Install/update plugins
:Lazy         " Check status
```

Add new plugins to `lua/plugins/init.lua` using Lazy's spec format.
