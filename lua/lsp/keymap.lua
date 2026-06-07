vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(args)
    local function opts(desc) return { buffer = args.buf, desc = desc } end

    vim.keymap.set("n", "<leader>cl", "<cmd>checkhealth vim.lsp<cr>", opts("Lsp Info"))

    vim.keymap.set("n", "gd", vim.lsp.buf.definition,     opts("Goto Definition"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references,     opts("References"))
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts("Goto Implementation"))
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts("Goto T[y]pe Definition"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration,    opts("Goto Declaration"))
    vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol,    opts("Document Symbols"))

    vim.keymap.set("n", "K",     vim.lsp.buf.hover,           opts("Hover"))
    vim.keymap.set("n", "gK",    vim.lsp.buf.signature_help,  opts("Signature Help"))
    vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help,  opts("Signature Help"))

    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
    vim.keymap.set({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run,    opts("Run Codelens"))
    vim.keymap.set("n",          "<leader>cC", function() vim.lsp.codelens.enable(true) end, opts("Refresh & Display Codelens"))
    vim.keymap.set("n",          "<leader>cr", vim.lsp.buf.rename,       opts("Rename"))

    vim.keymap.set({ "n", "x" }, "<leader>cA", function()
      vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
    end, opts("Source Action"))

    vim.keymap.set("n", "<leader>co", function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} } })
    end, opts("Organize Imports"))

    vim.keymap.set("n", "gai", vim.lsp.buf.incoming_calls, opts("Calls Incoming"))
    vim.keymap.set("n", "gao", vim.lsp.buf.outgoing_calls, opts("Calls Outgoing"))
  end,
})
