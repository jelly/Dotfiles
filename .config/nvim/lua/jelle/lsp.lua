local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
	local function keymap(key, fun)
		vim.keymap.set('n', key, fun, opts)
	end

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	keymap('gD', vim.lsp.buf.declaration)
	keymap('gd', vim.lsp.buf.definition)
	keymap('<leader>D', vim.lsp.buf.type_definition)
	keymap('gi', vim.lsp.buf.implementation)
	keymap('gr', vim.lsp.buf.references)
	keymap('gs', vim.diagnostic.open_float)
	keymap('ga', vim.lsp.buf.code_action)
	keymap('gR', vim.lsp.buf.rename)
	keymap('K', vim.lsp.buf.hover)
	keymap('<leader>wa', vim.lsp.buf.add_workspace_folder)
	keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder)
	keymap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders()))end)
	keymap('<leader>e', vim.diagnostic.open_float)
	keymap('[d', vim.diagnostic.goto_prev)
	keymap(']d', vim.diagnostic.goto_next)
end


-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {'clangd', 'pyright', 'rust_analyzer', 'tsserver'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		-- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
end
