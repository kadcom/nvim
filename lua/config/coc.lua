-- config/coc.lua
-- CoC (Conquer of Completion) configuration

local map = vim.keymap.set

-- Helper function for check_back_space
local function check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Tab completion
map("i", "<TAB>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif check_back_space() then
    return "<TAB>"
  else
    return vim.fn['coc#refresh']()
  end
end, { expr = true, silent = true })

map("i", "<S-TAB>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  else
    return "<C-h>"
  end
end, { expr = true, silent = true })

-- Use <c-space> to trigger completion
map("i", "<c-space>", "coc#refresh()", { expr = true, silent = true })

-- Make <CR> auto-select the first completion item
map("i", "<cr>", function()
  if vim.fn.pumvisible() == 1 then
    return vim.fn['coc#_select_confirm']()
  else
    return "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
  end
end, { expr = true, silent = true })

-- Navigation
map("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
map("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window
map("n", "K", function()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.fn['coc#rpc#ready']() then
    vim.fn['CocActionAsync']('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end, { silent = true })

-- Highlight the symbol and its references when holding the cursor
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("CocGroup", {}),
  command = "silent call CocActionAsync('highlight')"
})

-- Symbol renaming
map("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

-- Formatting selected code
map("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
map("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

-- Apply codeAction to the selected region
map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })
map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })

-- Remap keys for applying codeAction to the current buffer
map("n", "<leader>ac", "<Plug>(coc-codeaction)", { silent = true })
-- Apply AutoFix to problem on the current line
map("n", "<leader>qf", "<Plug>(coc-fix-current)", { silent = true })

-- Run the Code Lens action on the current line
map("n", "<leader>cl", "<Plug>(coc-codelens-action)", { silent = true })

-- Map function and class text objects
map("x", "if", "<Plug>(coc-funcobj-i)", { silent = true })
map("o", "if", "<Plug>(coc-funcobj-i)", { silent = true })
map("x", "af", "<Plug>(coc-funcobj-a)", { silent = true })
map("o", "af", "<Plug>(coc-funcobj-a)", { silent = true })
map("x", "ic", "<Plug>(coc-classobj-i)", { silent = true })
map("o", "ic", "<Plug>(coc-classobj-i)", { silent = true })
map("x", "ac", "<Plug>(coc-classobj-a)", { silent = true })
map("o", "ac", "<Plug>(coc-classobj-a)", { silent = true })

-- Remap <C-f> and <C-b> for scroll float windows/popups
map("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { expr = true, silent = true, nowait = true })
map("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { expr = true, silent = true, nowait = true })
map("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', { expr = true, silent = true, nowait = true })
map("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', { expr = true, silent = true, nowait = true })
map("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { expr = true, silent = true, nowait = true })
map("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { expr = true, silent = true, nowait = true })

-- Use CTRL-S for selections ranges
map("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
map("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocActionAsync('format')", {})

-- Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Mappings for CoCList
-- Show all diagnostics
map("n", "<space>a", ":<C-u>CocList diagnostics<cr>", { silent = true, nowait = true })
-- Manage extensions
map("n", "<space>e", ":<C-u>CocList extensions<cr>", { silent = true, nowait = true })
-- Show commands
map("n", "<space>c", ":<C-u>CocList commands<cr>", { silent = true, nowait = true })
-- Find symbol of current document
map("n", "<space>o", ":<C-u>CocList outline<cr>", { silent = true, nowait = true })
-- Search workspace symbols
map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", { silent = true, nowait = true })
-- Do default action for next item
map("n", "<space>j", ":<C-u>CocNext<CR>", { silent = true, nowait = true })
-- Do default action for previous item
map("n", "<space>k", ":<C-u>CocPrev<CR>", { silent = true, nowait = true })
-- Resume latest coc list
map("n", "<space>p", ":<C-u>CocListResume<CR>", { silent = true, nowait = true })

-- Autocommands for CoC
local coc_group = vim.api.nvim_create_augroup("CocAutoCmd", { clear = true })

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
  group = coc_group,
  pattern = { "typescript", "json" },
  command = "setl formatexpr=CocAction('formatSelected')",
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
  group = coc_group,
  pattern = "CocJumpPlaceholder",
  command = "call CocActionAsync('showSignatureHelp')",
})