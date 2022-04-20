local lspconfig = require('lspconfig')
local bring = require('jelle.utils')

local on_attach = function(client, bufnr)
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
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end


-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {'clangd', 'pyright', 'rust_analyzer', 'tsserver'}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
end

vim.lsp.handlers['textDocument/codeAction'] = require'telescope.builtin'.lsp_code_actions
vim.lsp.handlers['textDocument/references'] = require'telescope.builtin'.lsp_references
vim.lsp.handlers['textDocument/definition'] = require'telescope.builtin'.lsp_definitions
vim.lsp.handlers['textDocument/typeDefinition'] = require'telescope.builtin'.lsp_type_definitions
vim.lsp.handlers['textDocument/implementation'] = require'telescope.builtin'.lsp_implementations
vim.lsp.handlers['textDocument/documentSymbol'] = require'telescope.builtin'.lsp_document_symbols
vim.lsp.handlers['workspace/symbol'] = require'telescope.builtin'.lsp_workspace_symbols


local null_ls = require("null-ls")
null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.code_actions.eslint.with({
		extra_args = { "--ignore-pattern", "webpack.config.js" }
	}),
        null_ls.builtins.diagnostics.eslint.with({
		extra_args = { "--ignore-pattern", "webpack.config.js" }
	}),
	null_ls.builtins.formatting.trim_whitespace,
	null_ls.builtins.diagnostics.shellcheck,
	null_ls.builtins.code_actions.shellcheck,
	-- null_ls.builtins.completion.spell,
	null_ls.builtins.formatting.autopep8,
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
