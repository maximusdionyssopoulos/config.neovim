require("nvim-surround").setup()

require("mini.pairs").setup()
-- Only add the || pair for ruby files
-- ruby uses |...| for blocks but it also uses ||
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    MiniPairs.map_buf(
      0,
      "i",
      "|",
      { action = "closeopen", pair = "||", neigh_pattern = "^[^\\]", register = { cr = false } }
    )
  end,
})

require("mini.indentscope").setup({
  options = { try_as_border = true },
})
