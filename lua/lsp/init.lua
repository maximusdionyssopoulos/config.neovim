require("lsp.eslint")
require("lsp.lua_ls")

vim.lsp.enable({
	"lua_ls",
	"eslint",
	"vtsls",
	"rubocop",
	"ruby_lsp"
})

