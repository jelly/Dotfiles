local telescope = require('telescope')
telescope.load_extension('vimwiki')

local opts = { noremap=true, silent=true }
function keymap(key, fun)
	vim.keymap.set('n', key, fun, opts)
end

-- https://github.com/ElPiloto/telescope-vimwiki.nvim/issues/4
keymap('fw', ":Telescope vimwiki<cr>")
keymap('fv', require('telescope').extensions.vimwiki.live_grep)

local main_wiki = {
	path = '~/Notes/',
	path_html = '~/.cache/vimwiki/main/html',
	automatic_nested_syntaxes = 1,
	list_margin = 0,
	ext = '.md',
	syntax = 'markdown',
 	-- TODO: https://cristianpb.github.io/blog/vimwiki-hugo
	custom_wiki2html = '$HOME/bin/wiki2html.sh',
	template_ext = '.html',
}

local blog_wiki = {
	path = '~/projects/website/',
	automatic_nested_syntaxes = 1,
	list_margin = 0,
	ext = '.md',
	syntax = 'markdown',
}

vim.g['vimwiki_hl_headers'] = 1
vim.g['vimwiki_hl_cb_checked'] = 1
vim.g['vimwiki_use_calendar'] = 1
vim.g['vimwiki_listsyms'] = ' x'
vim.g['vimwiki_folding'] = ''
vim.g['vimwiki_list'] = {main_wiki, blog_wiki}
