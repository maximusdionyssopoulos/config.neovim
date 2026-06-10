require("nvim-treesitter").setup()
require("nvim-treesitter").install({ "ruby", "typescript", "tsx" })

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"
    vim.o.foldlevel = 99
  end,
})

require("nvim-ts-autotag").setup()
require("ts-comments").setup()
