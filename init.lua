require("plugins")
require("custom.remap")
require("custom.ui")
require("lsp")

-- Always use system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Inline diagnostic
vim.diagnostic.config({virtual_text = true})
