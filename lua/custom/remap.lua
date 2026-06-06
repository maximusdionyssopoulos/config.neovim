vim.g.mapleader = " "

-- PLUGINS
-- OIL
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>E", "<CMD>Oil.<CR>", { desc = "Open current working directory" })

-- FFF
vim.keymap.set('n', '<leader><leader>', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<leader>/', function() require("fff").live_grep() end, {desc = "FFFind content (Grep)"})

-- Buffers
vim.keymap.set("n", "<leader>,", function() require("mini.pick").builtin.buffers() end, { desc = "Pick from buffers"})
vim.keymap.set("n", "<leader>`", "<cmd>bn<CR>", { desc = "Go to next buffer"})

--- Helpers
vim.keymap.set("n", '<leader>y', function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, {desc = "Copy absolute path"})
vim.keymap.set("n", '<leader>yy', function() vim.fn.setreg("+", vim.fn.expand("%:.")) end, {desc = "Copy relative path"})

-- Split navigation
vim.keymap.set('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
vim.keymap.set('n', '<C-J>', '<C-w>j', { desc = 'Focus on below window' })
vim.keymap.set('n', '<C-K>', '<C-w>k', { desc = 'Focus on above window' })
vim.keymap.set('n', '<C-L>', '<C-w>l', { desc = 'Focus on right window' })
