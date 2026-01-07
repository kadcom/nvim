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

-- Copilot configuration
vim.g.copilot_no_tab_map = true -- Disable default Tab mapping (we use smart Tab in coc.lua)
vim.g.copilot_assume_mapped = true -- Tell Copilot we're handling the mapping ourselves
vim.g.copilot_enabled = true -- Ensure Copilot is enabled

-- Fallback Copilot mappings (if smart Tab doesn't work)
map('i', '<C-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false, silent = true }) -- Accept full suggestion
map('i', '<M-CR>', '<Plug>(copilot-accept-word)') -- Accept next word
map('i', '<M-]>', '<Plug>(copilot-accept-line)') -- Accept current line

-- CoC mappings will be loaded from config/coc.lua when the plugin loads