require("plugins")
require("lsp")
require("custom.re+keymap")
require("custom.ui")

-- Always use system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Inline diagnostic
vim.diagnostic.config({virtual_text = true})
