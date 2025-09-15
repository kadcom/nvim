-- keymaps.lua
-- Key mappings

local map = vim.keymap.set

-- General mappings
map("n", ",ee", ":%Eval<CR>", { buffer = true })
map("n", ",ef", ":Eval<CR>", { buffer = true })
map("n", ",b", ":buffers<CR>")
map("n", "<F5>", '"=strftime("%b %d, %Y")"<CR>P')

-- NERDTree mapping (will be set by plugin)
map("n", "<leader>e", ":NERDTreeToggle<CR>")

-- CoC mappings will be loaded from config/coc.lua when the plugin loads