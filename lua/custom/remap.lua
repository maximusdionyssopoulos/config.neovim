vim.g.mapleader = " "
vim.keymap.set("n", "<leader>b", "<cmd>buffers<CR>")

-- PLUGINS
-- OIL
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>E", "<CMD>Oil.<CR>", { desc = "Open current working directory" })

-- FFF
vim.keymap.set('n', '<leader><leader>', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<leader>/', function() require("fff").live_grep() end, {desc = "FFFind content (Grep)"})

--- Helpers
vim.keymap.set("n", '<leader>y', function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, {desc = "Copy absolute path"})
vim.keymap.set("n", '<leader>yy', function() vim.fn.setreg("+", vim.fn.expand("%:.")) end, {desc = "Copy relative path"})
