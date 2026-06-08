vim.g.mapleader = " "

local set = vim.keymap.set

--- Helpers
set("n", '<leader>y', function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, {desc = "Copy absolute path"})
set("n", '<leader>yy', function() vim.fn.setreg("+", vim.fn.expand("%:.")) end, {desc = "Copy relative path"})

-- Split navigation
set('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
set('n', '<C-J>', '<C-w>j', { desc = 'Focus on below window' })
set('n', '<C-K>', '<C-w>k', { desc = 'Focus on above window' })
set('n', '<C-L>', '<C-w>l', { desc = 'Focus on right window' })

-- PLUGINS
-- OIL
set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
set("n", "<leader>E", "<CMD>Oil.<CR>", { desc = "Open current working directory" })

-- FFF
set('n', '<leader><leader>', function() require('fff').find_files() end, { desc = 'FFFind files' })
set('n', '<leader>/', function() require("fff").live_grep() end, {desc = "FFFind content (Grep)"})

-- Buffers
set("n", "<leader>,", function() require("mini.pick").builtin.buffers() end, { desc = "Pick from buffers"})
set("n", "<leader>`", "<cmd>bn<CR>", { desc = "Go to next buffer"})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(args)
    local function opts(desc) return { buffer = args.buf, desc = desc } end

    set("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", opts("Lsp Info"))

    set("n", "gd", vim.lsp.buf.definition,     opts("Goto Definition"))
    set("n", "gr", vim.lsp.buf.references,     opts("References"))
    set("n", "gI", vim.lsp.buf.implementation, opts("Goto Implementation"))
    set("n", "gy", vim.lsp.buf.type_definition, opts("Goto T[y]pe Definition"))
    set("n", "gD", vim.lsp.buf.declaration,    opts("Goto Declaration"))
    set("n", "gO", vim.lsp.buf.document_symbol,    opts("Document Symbols"))

    set("n", "K",     vim.lsp.buf.hover,           opts("Hover"))
    set("n", "gK",    vim.lsp.buf.signature_help,  opts("Signature Help"))
    set("i", "<c-k>", vim.lsp.buf.signature_help,  opts("Signature Help"))

    set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
    set({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run,    opts("Run Codelens"))
    set("n",          "<leader>cC", function() vim.lsp.codelens.enable(true) end, opts("Refresh & Display Codelens"))
    set("n",          "<leader>cr", vim.lsp.buf.rename,       opts("Rename"))

    set({ "n", "x" }, "<leader>cA", function()
      vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
    end, opts("Source Action"))

    set("n", "<leader>co", function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} } })
    end, opts("Organize Imports"))

    set("n", "gai", vim.lsp.buf.incoming_calls, opts("Calls Incoming"))
    set("n", "gao", vim.lsp.buf.outgoing_calls, opts("Calls Outgoing"))
  end,
})
