require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.config("eslint", {
  settings = {
    rulesCustomizations = {
      { rule = "import/*", severity = "off" },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

vim.lsp.enable({
	"lua_ls",
	"eslint",
	"vtsls",
	"rubocop",
	"ruby_lsp"
})
