vim.lsp.config("eslint", {
  settings = {
    rulesCustomizations = {
      { rule = "import/*", severity = "off" },
    },
  },
})
