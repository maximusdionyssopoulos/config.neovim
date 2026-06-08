require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    odin = { "odinfmt" },
    ruby = { "rubocop" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
