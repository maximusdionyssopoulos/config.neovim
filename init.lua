--#region: UI & OPT
-- Inline diagnostic
vim.diagnostic.config({ virtual_text = true })

-- relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- sign column (i.e. lsp errors)
vim.opt.signcolumn = "yes:1"
vim.opt.numberwidth = 4

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "--#region,--#endregion"
vim.o.foldlevel = 99
--#endregion

--#region: User Commands
local crt_u_cmd = vim.api.nvim_create_user_command
crt_u_cmd("CopyAbsolutePath", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, {})
crt_u_cmd("CopyRelativePath", function() vim.fn.setreg("+", vim.fn.expand("%:.")) end, {})

crt_u_cmd("ConfigAuditPlugins", function() vim.pack.update(nil, { offline = true }) end, {}) -- not active ; gra to open delete menu

crt_u_cmd("Regions", function() vim.cmd("vimgrep /#region/ % | copen") end, {})
--#endregion

--#region: Plugins
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "fff.nvim" and (kind == "install" or kind == "update") then
      if not ev.data.active then vim.cmd.packadd("fff.nvim") end
      require("fff.download").download_or_build_binary()
    end
  end,
})

--#region: Picker & Grep (FFF)
vim.pack.add({
  { src = "https://github.com/dmtrKovalenko/fff.nvim" },
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = true, show_scores = true },
}
require("fff").setup({
  keymaps = {
    cycle_grep_modes = "<M-Tab>",
  },
})
--#endregion

--#region: Colour Scheme
vim.pack.add({ { src = "https://github.com/savq/melange-nvim" } })
vim.cmd.colorscheme("melange")
--#endregion

--#region: Files (Oil)
vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim" } })
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
--#endregion

--#region: Completion (Blink)
vim.pack.add({
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },
})
local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  completion = {
    ghost_text = { enabled = true },
  },
})
--#endregion

--#region: LSP
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})
require("mason").setup()
require("mason-lspconfig").setup()

vim.lsp.config("eslint", {
  settings = {
    rulesCustomizations = {
      { rule = "import/*", severity = "off" },
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

vim.lsp.enable({
  "lua_ls",
  "eslint",
  "vtsls",
  "rubocop",
  "ruby_lsp",
})
--#endregion

--#region: Treesitter (TS, Autotag, Endwise, TS-Comments)
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/tpope/vim-endwise" },
  { src = "https://github.com/folke/ts-comments.nvim" },
})
require("nvim-treesitter").setup()
require("nvim-treesitter").install({ "ruby", "typescript", "tsx" })

-- vim.api.nvim_create_autocmd("FileType", {
--   callback = function()
--     pcall(vim.treesitter.start)
--     vim.bo.syntax = "ON"
--
--     vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
--     vim.wo[0][0].foldmethod = "expr"
--     vim.o.foldlevel = 99
--   end,
-- })

require("nvim-ts-autotag").setup()
require("ts-comments").setup()
--#endregion

--#region: Formatter (Confirm)
vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    odin = { "odinfmt" },
    ruby = { "rubocop" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
--#endregion

--#region: Extra (Surround, Pairs, Indentscope)
vim.pack.add({
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("4.x") },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.indentscope" },
})
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
require("mini.indentscope").setup({ options = { try_as_border = true } })
--#endregion

--#region: Git
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk)
    map("n", "<leader>hr", gitsigns.reset_hunk)

    map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

    map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

    map("n", "<leader>hS", gitsigns.stage_buffer)
    map("n", "<leader>hR", gitsigns.reset_buffer)
    map("n", "<leader>hp", gitsigns.preview_hunk)
    map("n", "<leader>hi", gitsigns.preview_hunk_inline)

    map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end)

    map("n", "<leader>hd", gitsigns.diffthis)

    map("n", "<leader>hD", function() gitsigns.diffthis("~") end)

    map("n", "<leader>hQ", function() gitsigns.setqflist("all") end)
    map("n", "<leader>hq", gitsigns.setqflist)

    -- Toggles
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    map("n", "<leader>tw", gitsigns.toggle_word_diff)

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk)
  end,
})
--#endregion

--#endregion

--#region: Keymap
vim.g.mapleader = " "

local set = vim.keymap.set

--- Helpers
set("n", "<leader>ya", "<cmd>CopyAbsolutePath<cr>", { desc = "Copy absolute path" })
set("n", "<leader>yr", "<cmd>CopyRelativePath<cr>", { desc = "Copy relative path" })
set({ "n", "x" }, "sy", '"+y', { desc = "Copy to system clipboard" })
set({ "n", "x" }, "sp", '"+p', { desc = "Paste from system clipboard" })

-- Split navigation
set("n", "<C-H>", "<C-w>h", { desc = "Focus on left window" })
set("n", "<C-J>", "<C-w>j", { desc = "Focus on below window" })
set("n", "<C-K>", "<C-w>k", { desc = "Focus on above window" })
set("n", "<C-L>", "<C-w>l", { desc = "Focus on right window" })

-- PLUGINS
-- OIL
set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
set("n", "<leader>E", "<CMD>Oil.<CR>", { desc = "Open current working directory" })

-- FFF
set("n", "<leader><leader>", function() require("fff").find_files() end, { desc = "FFFind files" })
set("n", "<leader>/", function() require("fff").live_grep() end, { desc = "FFFind content (Grep)" })

-- Buffers
set("n", "<leader>`", "<cmd>bn<CR>", { desc = "Go to next buffer" })
set("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
set("n", "<leader>bD", ":%bd<CR>", { desc = "Close All Buffers" })
set("n", "<leader>bx", ":%bd|e#|bd#<CR>", { desc = "Close All Other Buffers" })

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(args)
    local function opts(desc) return { buffer = args.buf, desc = desc } end

    set("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", opts("Lsp Info"))

    set("n", "gd", vim.lsp.buf.definition, opts("Goto Definition"))
    set("n", "gr", vim.lsp.buf.references, opts("References"))
    set("n", "gI", vim.lsp.buf.implementation, opts("Goto Implementation"))
    set("n", "gy", vim.lsp.buf.type_definition, opts("Goto T[y]pe Definition"))
    set("n", "gD", vim.lsp.buf.declaration, opts("Goto Declaration"))
    set("n", "gO", vim.lsp.buf.document_symbol, opts("Document Symbols"))

    set("n", "K", vim.lsp.buf.hover, opts("Hover"))
    set("n", "gK", vim.lsp.buf.signature_help, opts("Signature Help"))
    set("i", "<c-k>", vim.lsp.buf.signature_help, opts("Signature Help"))

    set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
    set({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, opts("Run Codelens"))
    set("n", "<leader>cC", function() vim.lsp.codelens.enable(true) end, opts("Refresh & Display Codelens"))
    set("n", "<leader>cr", vim.lsp.buf.rename, opts("Rename"))

    set(
      { "n", "x" },
      "<leader>cA",
      function() vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } }) end,
      opts("Source Action")
    )

    set(
      "n",
      "<leader>co",
      function() vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} } }) end,
      opts("Organize Imports")
    )

    set("n", "gai", vim.lsp.buf.incoming_calls, opts("Calls Incoming"))
    set("n", "gao", vim.lsp.buf.outgoing_calls, opts("Calls Outgoing"))
  end,
})
--#endregion

--#region: CUSTOM
require("lua.set-theme")
--#endregion
