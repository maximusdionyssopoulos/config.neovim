require("oil").setup({
  delete_to_trash = true,
  watch_for_changes = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<C-l>"] = false,
    ["<C-h>"] = false,
    ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
  },
})
