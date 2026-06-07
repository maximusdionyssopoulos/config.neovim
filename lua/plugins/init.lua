vim.pack.add({
-- colorscheme
{ src = "https://github.com/savq/melange-nvim" },

-- files
{ src = "https://github.com/stevearc/oil.nvim" },

-- completion
{ src = 'https://github.com/saghen/blink.lib' },
{ src = 'https://github.com/Saghen/blink.cmp' },

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
{ src = 'https://github.com/nvim-mini/mini.pairs' },

-- picker, grep 
{ src = "https://github.com/dmtrKovalenko/fff.nvim" },


})
-- Colour Scheme
vim.cmd.colorscheme('melange')

-- Files
require("oil").setup({
	delete_to_trash = true,
	watch_for_changes = true,
	view_options = {
		show_hidden = true
	},
	keymaps = {
		["<C-l>"] = false,
		["<C-h>"] = false,
		["<C-s>"] = {"actions.select", opts = { horizontal=true }},
		["<C-v>"] = {"actions.select", opts = { vertical=true }},
	}

})

-- LSP
require("mason").setup()
require("mason-lspconfig").setup()

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup()

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

-- Picker
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff.nvim' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff.nvim') end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = true, show_scores = true },
}
require("fff").setup({})

