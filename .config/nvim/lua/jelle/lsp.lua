local lspconfig = require('lspconfig')
local bring = require('jelle.utils')
local navic = require('nvim-navic')
local telescope = require('telescope.builtin')

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
	keymap('gd', bring.bring_or_create, "[G]oto [D]efinition")
	keymap('<leader>D', vim.lsp.buf.type_definition, "Type [D]efinition")
	keymap('gr', vim.lsp.buf.references, "[G]oto [R]eferences")
	keymap('gs', telescope.lsp_dynamic_workspace_symbols, "[G]oto [S]ymbols show workspace symbols")
	keymap('ga', vim.lsp.buf.code_action, "[G]o [A]ction")
	keymap('gR', vim.lsp.buf.rename, "[G]o [R]ename")
	keymap('K', vim.lsp.buf.hover, "Hover documentation")
        keymap('<C-k>', vim.lsp.buf.signature_help, "Signature documentation")
	keymap('[d', vim.diagnostic.goto_prev, "[d previous diagnostic")
	keymap(']d', vim.diagnostic.goto_next, "]d next diagnostic")
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { filter = function(client) return client.name ~= "tsserver" end, async = true }']]
end

-- Messes up function / JSX formatting in JSX.
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   buffer = buffer,
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end
-- })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {'ccls', 'rust_analyzer', 'tsserver', 'gopls', 'marksman', 'ruff_lsp', 'eslint'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
end

lspconfig.pyright.setup {
	on_attach = on_attach,
	capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	root_dir = function()
		return vim.fn.getcwd()
	end,
	settings = {
		python = {
			analysis = {
				extraPaths = { "/home/jelle/projects/cockpit/main/test/common",
					       "/home/jelle/projects/cockpit-bots/machine",
					       "/home/jelle/projects/cockpit-bots",
				}
			}
		}
	}
}

vim.lsp.handlers['textDocument/codeAction'] = telescope.lsp_code_actions
vim.lsp.handlers['textDocument/references'] = telescope.lsp_references
vim.lsp.handlers['textDocument/definition'] = telescope.lsp_definitions
vim.lsp.handlers['textDocument/typeDefinition'] = telescope.lsp_type_definitions
vim.lsp.handlers['textDocument/implementation'] = telescope.lsp_implementations
vim.lsp.handlers['textDocument/documentSymbol'] = telescope.lsp_document_symbols
vim.lsp.handlers['workspace/symbol'] = telescope.lsp_workspace_symbols
