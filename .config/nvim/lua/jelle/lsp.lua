local lspconfig = require('lspconfig')
local bring = require('jelle.utils')
local navic = require('nvim-navic')
local telescope = require('telescope.builtin')

local on_attach = function(client, bufnr)
    navic.attach(client, bufnr)

    local opts = { noremap=true, silent=true, buffer=bufnr }
	local function keymap(key, fun)
		vim.keymap.set('n', key, fun, opts)
	end

	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	keymap('gD', vim.lsp.buf.declaration)
	keymap('gd', bring.bring_or_create)
	keymap('<leader>D', vim.lsp.buf.type_definition)
	keymap('gi', vim.lsp.buf.implementation)
	keymap('gr', vim.lsp.buf.references)
	keymap('gs', telescope.lsp_dynamic_workspace_symbols)
	keymap('ga', vim.lsp.buf.code_action)
	keymap('gR', vim.lsp.buf.rename)
	keymap('K', vim.lsp.buf.hover)
        keymap('<C-k>', vim.lsp.buf.signature_help)
	keymap('<leader>wa', vim.lsp.buf.add_workspace_folder)
	keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder)
	keymap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders()))end)
	keymap('<leader>e', vim.diagnostic.open_float)
	keymap('[d', vim.diagnostic.goto_prev)
	keymap(']d', vim.diagnostic.goto_next)
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
end


-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {'ccls', 'rust_analyzer', 'tsserver', 'gopls'}
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


local null_ls = require("null-ls")
require('crates').setup {
    null_ls = {
        enabled = true,
        name = "crates.nvim",
    },
}

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.eslint_d.with({
		extra_args = { "--ignore-pattern", "webpack.config.js" }
	}),
        null_ls.builtins.formatting.eslint_d.with({
		extra_args = { "--ignore-pattern", "webpack.config.js" }
	}),
        null_ls.builtins.diagnostics.eslint_d.with({
		extra_args = { "--ignore-pattern", "webpack.config.js" }
	}),
	null_ls.builtins.diagnostics.stylelint,
	null_ls.builtins.formatting.trim_whitespace,
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.code_actions.shellcheck,
	-- null_ls.builtins.completion.spell,
	null_ls.builtins.formatting.autopep8,
	null_ls.builtins.diagnostics.flake8.with({
		extra_args = { "--max-line-length", "300" }
	}),
    },
    -- Enable when formatting plugins are stable
    -- on_attach = function(client)
    --     if client.resolved_capabilities.document_formatting then
    --         vim.cmd([[
    --         augroup LspFormatting
    --             autocmd! * <buffer>
    --             autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    --         augroup END
    --         ]])
    --     end
    -- end,
})
