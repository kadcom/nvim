# Neovim Configuration

A modern Neovim configuration using Lazy.nvim plugin manager with modular Lua-based structure.

## Features

- **Plugin Manager**: Lazy.nvim with lazy loading for fast startup
- **Language Support**: CoC.nvim for LSP features, vim-go, and multiple language plugins
- **File Navigation**: NERDTree, CtrlP, and FZF integration
- **AI Assistance**: GitHub Copilot and Avante.nvim
- **Git Integration**: vim-fugitive and vim-signify
- **Syntax Highlighting**: nvim-treesitter with rainbow parentheses
- **Modern UI**: vim-airline with Solarized8 colorscheme

## Installation

1. Backup your existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. Start Neovim:
   ```bash
   nvim
   ```

4. Lazy.nvim will automatically install all plugins on first run.

## Key Mappings

- `\e` - Toggle NERDTree
- `gd` - Go to definition (CoC)
- `gr` - Find references (CoC)
- `\rn` - Rename symbol (CoC)
- `K` - Show documentation (CoC)
- `,b` - List buffers
- `F5` - Insert current date

## Configuration Structure

```
├── init.lua                 # Main entry point and Lazy.nvim bootstrap
├── lua/
│   ├── options.lua         # Vim options and settings
│   ├── keymaps.lua         # Key mappings
│   ├── plugins/
│   │   └── init.lua        # Plugin specifications
│   └── config/
│       └── coc.lua         # CoC language server configuration
├── COPYING                 # MIT license
└── README.md               # This file
```

## Plugin Management

- **Install/Update plugins**: `:Lazy sync`
- **Check plugin status**: `:Lazy`
- **Add new plugins**: Edit `lua/plugins/init.lua`

## Language Server Support

This configuration uses CoC.nvim for language server features. Install language servers with:

```vim
:CocInstall coc-tsserver coc-json coc-html coc-css coc-python
```

Available commands:
- `:Format` - Format current buffer
- `:OR` - Organize imports
- `:Fold` - Fold current buffer

## Requirements

- Neovim >= 0.8
- Git
- Node.js (for CoC.nvim)
- ctags at `/opt/homebrew/bin/ctags` (for gutentags)

## License

MIT License - see COPYING file for details.