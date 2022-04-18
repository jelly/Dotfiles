call plug#begin('~/.config/nvim/plugged')

" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Git integration
Plug 'tpope/vim-fugitive'

" Colorscheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" LSP
Plug 'neovim/nvim-lspconfig'

call plug#end()
