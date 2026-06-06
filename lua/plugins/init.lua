vim.pack.add({
-- colorscheme
{ src = "https://github.com/savq/melange-nvim" },

-- files
{ src = "https://github.com/stevearc/oil.nvim" },

-- lsp 
{ src = 'https://github.com/neovim/nvim-lspconfig' },
{ src = 'https://github.com/mason-org/mason.nvim' },
{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },

-- treesitter
{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
{ src = 'https://github.com/windwp/nvim-ts-autotag' },
{ src = 'https://github.com/rrethy/nvim-treesitter-endwise'},

-- helpers
{ src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
{ src = 'https://github.com/nvim-mini/mini.pairs', version = 'stable' },

})
-- Colour Scheme
vim.cmd.colorscheme('melange')

-- Files
require("oil").setup({
	delete_to_trash = true,
	watch_for_changes = true,
	view_options = {
		show_hidden = true
	}

})

-- LSP
require("mason").setup()
require("mason-lspconfig").setup()

-- Treesitter
require('nvim-treesitter').setup()
require('nvim-ts-autotag').setup()
-- require("nvim-treesitter-endwise").setup()

-- Helpers 
require("nvim-surround").setup()
require("mini.pairs").setup({
	mappings = {
		['|'] = {action = "closeopen", pair = '||', neigh_pattern = '^[^\\]',   register = { cr = false }}
	}
})


