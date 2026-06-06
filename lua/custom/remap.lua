vim.g.mapleader = " "
vim.keymap.set("n", "<leader>b", "<cmd>buffers<CR>")

-- PLUGINS
-- OIL
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- FFF
vim.keymap.set('n', '<leader><leader>', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<leader>/', function() require("fff").live_grep() end, {desc = "FFFind content (Grep)"})
