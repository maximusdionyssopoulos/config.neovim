require("lsp.eslint")
require("lsp.lua_ls")
require("lsp.keymap")

vim.lsp.enable({
	"lua_ls",
	"eslint",
	"vtsls",
	"rubocop",
	"ruby_lsp"
})

