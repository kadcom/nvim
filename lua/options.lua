-- options.lua
-- Neovim options and settings

local opt = vim.opt

-- General settings
opt.compatible = false
opt.encoding = "utf-8"
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.updatetime = 300
opt.timeoutlen = 500

-- Display
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showcmd = true
opt.showmode = true
opt.signcolumn = "number"
opt.termguicolors = true
opt.background = "dark"

-- Colorcolumn - set multiple columns from 120 to 335
local columns = {}
for i = 120, 335 do
  table.insert(columns, tostring(i))
end
opt.colorcolumn = table.concat(columns, ",")

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smarttab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Completion
opt.wildmenu = true
opt.wildmode = "list:longest"
opt.shortmess:append("c")
opt.completeopt = { "menuone", "noselect" }

-- Backspace behavior
opt.backspace = { "indent", "eol", "start" }

-- Clipboard
opt.clipboard = "unnamed"

-- Command line
opt.cmdheight = 2

-- Tags
opt.tags = "tags;/,codex.tags;/"

-- File detection
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- Autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- File type detection
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup,
  pattern = "*.m",
  command = "set filetype=objc",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup,
  pattern = "*.md",
  command = "set filetype=markdown",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup,
  pattern = "BUCK",
  command = "set filetype=python",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup,
  pattern = "Fastfile",
  command = "set filetype=ruby",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup,
  pattern = "*.svelte",
  command = "set syntax=svelte",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup,
  pattern = "*.wgsl",
  command = "set filetype=wgsl",
})

-- Global variables
vim.g.templates_no_autocmd = 1
vim.g.gutentags_ctags_executable = "/opt/homebrew/bin/ctags"

-- Terminal color sequences for RGB (only needed for Vim, not Neovim)
-- Neovim handles true color automatically with termguicolors