local navic = require('nvim-navic')
local telescope = require('telescope.builtin')

local capabilities = vim.lsp.protocol.make_client_capabilities()
if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = nil
end
vim.lsp.config('*', {
  capabilities = capabilities,
})

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    local opts = { noremap=true, silent=true, buffer=bufnr }
	local function keymap(key, fun, desc)
		opts.desc = desc
		vim.keymap.set('n', key, fun, opts)
	end

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- :Telescope keymaps
	keymap('gD', vim.lsp.buf.declaration, "[G]o to [D]eclaration")
	keymap('gd', vim.lsp.buf.definition, "[G]oto [D]efinition")
	keymap('<leader>D', vim.lsp.buf.type_definition, "Type [D]efinition")
	keymap('gi', vim.lsp.buf.implementation, "[G]oto [I]implementation")
	keymap('gr', vim.lsp.buf.references, "[G]oto [R]eferences")
	keymap('gs', telescope.lsp_dynamic_workspace_symbols, "[G]oto [S]ymbols show workspace symbols")
	keymap('ga', vim.lsp.buf.code_action, "[G]o [A]ction")
	keymap('gR', vim.lsp.buf.rename, "[G]o [R]ename")
        keymap('<C-k>', vim.lsp.buf.signature_help, "Signature documentation")
end

vim.lsp.config('clangd', {
	on_attach = on_attach,
        cmd = { 'clangd', '--background-index' },
        filetypes = { 'c', 'cpp' },
        root_markers = { '.clang-tidy', 'compile_commands.json', 'build/compile_commands.json', 'configure.ac' },
        settings = {},
})
vim.lsp.enable('clangd')

vim.lsp.config('ts_ls', {
	on_attach = on_attach,
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_markers = { 'package.json' },
        settings = {},
})
vim.lsp.enable('ts_ls')

vim.lsp.config('pyright', {
	on_attach = on_attach,
	cmd = { "pyright-langserver", "--stdio"},
	filetypes = { "python" },
	settings = {
	  python = {
	    analysis = {
	      autoSearchPaths = true,
	      diagnosticMode = "workspace",
	      useLibraryCodeForTypes = true
	    }
	  }
       },
})
vim.lsp.enable('pyright')

vim.lsp.config('ruff', {
	on_attach = on_attach,
        cmd = { 'ruff', 'server' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml' },
        settings = {},
})
vim.lsp.enable('ruff')

vim.lsp.config('marksman', {
	on_attach = on_attach,
        cmd = { 'marksman', 'server' },
        filetypes = { 'markdown', 'vimwiki' },
        root_markers = { '.git' },
        settings = {},
})
vim.lsp.enable('marksman')


vim.lsp.handlers['textDocument/codeAction'] = telescope.lsp_code_actions
vim.lsp.handlers['textDocument/references'] = telescope.lsp_references
vim.lsp.handlers['textDocument/definition'] = telescope.lsp_definitions
vim.lsp.handlers['textDocument/typeDefinition'] = telescope.lsp_type_definitions
vim.lsp.handlers['textDocument/implementation'] = telescope.lsp_implementations
vim.lsp.handlers['textDocument/documentSymbol'] = telescope.lsp_document_symbols
vim.lsp.handlers['workspace/symbol'] = telescope.lsp_workspace_symbols

vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.open_float(0, {scope='line'}) end)


vim.diagnostic.config({
    severity = {
        min = vim.diagnostic.severity.INFO,
    },
    virtual_lines = {
        current_line = true,
    },
})
