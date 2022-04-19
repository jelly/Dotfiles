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

" Comments
Plug 'numToStr/Comment.nvim'

" Linting
" https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

call plug#end()

lua require('Comment').setup()
lua require("luasnip.loaders.from_vscode").lazy_load()
