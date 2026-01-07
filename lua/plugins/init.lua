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

  -- Startup screen with time-based greeting
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      local hour = tonumber(os.date("%H"))
      local ascii

      if hour >= 5 and hour < 12 then
        -- 早安 (Good morning)
        ascii = {
          [[           @@@@@@@@@@@@@@@@@               @@@                  ]],
          [[          @@@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[          @@@              @@@    @@@                 @@@       ]],
          [[          @@@@@@@@@@@@@@@@@@@@    @@@      @@@       @@@@       ]],
          [[          @@@             *@@@            @@@     *@@:@         ]],
          [[          @@@             #@@@   @@@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[          @@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[                  @@@                 @@@        @@@            ]],
          [[        @@@@@@@@@:@@@+@@@@@@@@@     @@@@@:     @@@@             ]],
          [[       @@@@@@@@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@               ]],
          [[                  @@@                     @@@@@@@@@             ]],
          [[                  @@@            @@@@@@@@@@@@   @@@@@@@@        ]],
          [[                  @@@            @@@@@@@            @@@@@       ]],
          [[]],
          [[                      光凱理，準備寫程式吧！                      ]],
        }
      elseif hour >= 12 and hour < 18 then
        -- 午安 (Good afternoon)
        ascii = {
          [[             @@@+                          @@@                  ]],
          [[            :@@@ #@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[           @@@@@@@@@@@@@@@@@@@@   @@@                 @@@       ]],
          [[          @@@@     @@*            @@@      @@@       @@@@       ]],
          [[        @@@@      %@@@                    @@@     *@@:@         ]],
          [[         @@       #@@@           @@@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[                   @@%           @@@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[       @@@@@@@@@@@@@@@@@@@@@@@@@      @@@        @@@            ]],
          [[                   @@#              @@@@@:     @@@@             ]],
          [[                  %@@@                @@@@@@@@@@@               ]],
          [[                  %@@@                    @@@@@@@@@             ]],
          [[                  %@@@           @@@@@@@@@@@@   @@@@@@@@        ]],
          [[                  @@@@           @@@@@@@            @@@@@       ]],
          [[]],
          [[                      光凱理，準備寫程式吧！                      ]],
        }
      else
        -- 晚安 (Good evening)
        ascii = {
          [[                    @@@:                   @@@                  ]],
          [[        @@@@@@@    @@@@@@@@@      @@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[        @@@  @@   @@@    @@@@     @@@                 @@@       ]],
          [[        @@@  @@ @@@     @@@       @@@      @@@       @@@@       ]],
          [[        @@@  @@ @@@@@@@@@@@@@@            @@@     *@@:@         ]],
          [[        @@@  @@  @@   @@@   @@@  @@@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[        @@@@@@@  @@   @@@   @@%  @@@@@@@@@@@@@@@@@@@@@@@@       ]],
          [[        @@%  @@  @@@@@@@@@@@@@@       @@@        @@@            ]],
          [[        @@@  @@  @@@@@@@@@@@@@      @@@@@:     @@@@             ]],
          [[        @@@  @@     +@@@@@    @:      @@@@@@@@@@@               ]],
          [[        @@%  @@    @@@ @@@   @@@          @@@@@@@@@             ]],
          [[        @@@@@@@ @@@@@  @@@@@@@@@ @@@@@@@@@@@@   @@@@@@@@        ]],
          [[         @@@@@ @@@@     @@@@@@@  @@@@@@@            @@@@@       ]],
          [[]],
          [[                      光凱理，準備寫程式吧！                      ]],
        }
      end

      dashboard.section.header.val = ascii
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Find file", ":Files<CR>"),
        dashboard.button("r", "  Recent", ":CocList mru<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"

      alpha.setup(dashboard.config)

      -- Open NERDTree after alpha is ready
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        once = true,
        callback = function()
          vim.schedule(function()
            vim.cmd("NERDTreeToggle")
          end)
        end,
      })

      -- Close alpha when opening a file (e.g., from NERDTree)
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local buftype = vim.bo.filetype
          -- If entering a real file buffer (not NERDTree, not alpha)
          if bufname ~= "" and buftype ~= "alpha" and not bufname:match("NERD_tree") then
            -- Schedule deletion to avoid conflicts with alpha's autocommands
            vim.schedule(function()
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(buf) then
                  local ok, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
                  if ok and ft == "alpha" then
                    pcall(vim.api.nvim_buf_delete, buf, { force = true })
                  end
                end
              end
            end)
          end
        end,
      })
    end,
  },

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

  -- nvim-cmp (fallback completion when CoC is not available)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },

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
