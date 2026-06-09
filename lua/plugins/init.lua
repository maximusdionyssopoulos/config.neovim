vim.pack.add({
  -- colorscheme
  { src = "https://github.com/savq/melange-nvim" },

  -- files
  { src = "https://github.com/stevearc/oil.nvim" },

  -- completion
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },

  -- lsp
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

  -- treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/tpope/vim-endwise" },

  -- formatter
  { src = "https://github.com/stevearc/conform.nvim" },

  -- picker, grep
  { src = "https://github.com/dmtrKovalenko/fff.nvim" },

  -- extra
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.indentscope" },

  -- git
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})
-- Colour Scheme
vim.cmd.colorscheme("melange")

-- Files
require("plugins.oil")
-- LSP
require("plugins.lsp")
require("plugins.cmp")

-- Treesitter
require("plugins.treesitter")

-- Formatter
require("plugins.formatter")

-- Helpers
require("plugins.extra")

-- Picker
require("plugins.fff")

-- Git
require("plugins.git")
