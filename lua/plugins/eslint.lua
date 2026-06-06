return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {
        settings = {
          rulesCustomizations = {
            { rule = "import/*", severity = "off" },
          },
        },
      },
    },
  },
}
