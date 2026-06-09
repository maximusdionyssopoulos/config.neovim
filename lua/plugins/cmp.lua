local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  completion = {
    ghost_text = { enabled = true },
  },
})
