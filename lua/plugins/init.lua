-- plugins/init.lua
-- Plugin specifications for Lazy.nvim

return {
  -- UI and Visual
  {
    "lifepillar/vim-solarized8",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme solarized8")
    end,
  },

  {
    "kien/rainbow_parentheses.vim",
    event = "VimEnter",
    config = function()
      vim.g.rbpt_colorpairs = {
        { "13", "#6c71c4" },
        { "5", "#d33682" },
        { "1", "#dc322f" },
        { "9", "#cb4b16" },
        { "3", "#b58900" },
        { "2", "#859900" },
        { "6", "#2aa198" },
        { "4", "#268bd2" },
      }

      vim.cmd("autocmd VimEnter * RainbowParenthesesToggle")
      vim.cmd("autocmd Syntax * RainbowParenthesesLoadRound")
      vim.cmd("autocmd Syntax * RainbowParenthesesLoadSquare")
      vim.cmd("autocmd Syntax * RainbowParenthesesLoadBraces")
    end,
  },

  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    event = "VimEnter",
    config = function()
      vim.opt.statusline = vim.opt.statusline + "%{coc#status()}%{get(b:,'coc_current_function','')}"
    end,
  },

  { "vim-airline/vim-airline-themes", lazy = true },

  -- File Management
  {
    "preservim/nerdtree",
    cmd = { "NERDTreeToggle", "NERDTreeFind" },
    keys = {
      { "<leader>e", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
    },
    dependencies = {
      "ryanoasis/vim-devicons",
      "tiagofumo/vim-nerdtree-syntax-highlight",
    },
    config = function()
      vim.g.NERDTreeShowBookmarks = 1
      vim.g.NERDTreeIgnore = { '\\.py[cd]$', '\\~$', '\\.swo$', '\\.swp$', '^\\.git$', '^\\.hg$', '^\\.svn$', '\\.bzr$' }
      vim.g.NERDTreeChDirMode = 0
      vim.g.NERDTreeQuitOnOpen = 1
      vim.g.NERDTreeMouseMode = 2
      vim.g.NERDTreeShowHidden = 1
      vim.g.NERDTreeKeepTreeInNewTab = 1
      vim.g.nerdtree_tabs_open_on_gui_startup = 0
      vim.g.NERDTreeWinSize = 30

      -- Auto-open NERDTree on startup
      vim.cmd("autocmd VimEnter * NERDTree")
    end,
  },

  { "ryanoasis/vim-devicons", lazy = true },
  { "tiagofumo/vim-nerdtree-syntax-highlight", lazy = true },

  -- Fuzzy Finding
  { "ctrlpvim/ctrlp.vim", keys = { "<C-p>" } },
  { "junegunn/fzf.vim", cmd = { "FZF", "Rg", "Files" } },

  -- Language Server and Completion
  {
    "neoclide/coc.nvim",
    branch = "release",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("config.coc")
    end,
  },

  -- Language Support
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoUpdateBinaries",
  },

  { "tikhomirov/vim-glsl", ft = { "glsl", "vert", "frag" } },
  { "hsanson/vim-android", ft = { "java", "kotlin" } },
  { "habamax/vim-asciidoctor", ft = "asciidoc" },
  { "joerdav/templ.vim", ft = "templ" },
  { "gfontenot/vim-xcode", ft = { "swift", "objc" } },
  { "wreien/vim-jasmin", ft = "jasmin" },

  -- Git Integration
  {
    "mhinz/vim-signify",
    cond = function()
      return vim.fn.executable("git") == 1
    end,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "tpope/vim-fugitive",
    cond = function()
      return vim.fn.executable("git") == 1
    end,
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },

  -- Utilities
  { "tpope/vim-sensible" },
  { "ludovicchabant/vim-gutentags", event = { "BufReadPre", "BufNewFile" } },

  -- AI Assistants
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },

  {
    "andweeb/presence.nvim",
    event = "VimEnter",
    config = function()
      -- vim.g.presence_log_level = "debug"
    end,
  },

  -- Avante.nvim and dependencies
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "go" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "MeanderingProgrammer/render-markdown.nvim", ft = "markdown" },
  { "hrsh7th/nvim-cmp", event = "InsertEnter" },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "HakonHarnes/img-clip.nvim", keys = { "<leader>p" } },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "HakonHarnes/img-clip.nvim",
      "github/copilot.vim",
    },
  },

  -- Font installation (lazy loaded)
  {
    "powerline/fonts",
    lazy = true,
    build = "./install.sh",
  },

  -- Compatibility for older Vim (not needed for Neovim, but keeping for reference)
  -- {
  --   "roxma/nvim-yarp",
  --   cond = function() return not vim.fn.has("nvim") end,
  -- },
  -- {
  --   "roxma/vim-hug-neovim-rpc",
  --   cond = function() return not vim.fn.has("nvim") end,
  -- },
}