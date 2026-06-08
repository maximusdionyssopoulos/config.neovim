require("nvim-surround").setup()
require("mini.pairs").setup({
  mappings = {
    ["|"] = { action = "closeopen", pair = "||", neigh_pattern = "^[^\\]", register = { cr = false } },
  },
})

require("mini.indentscope").setup({
  options = { try_as_border = true },
})
