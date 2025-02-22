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
Plug 'j-hui/fidget.nvim', { 'tag': 'v1.6.1' }

" Linting
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Searching, requires ripgrep/fd
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'benfowler/telescope-luasnip.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'SmiteshP/nvim-navic'

" Wiki
Plug 'vimwiki/vimwiki', {'on' : ['VimwikiIndex', 'VimwikiUISelect'], 'for': 'wiki' }
Plug 'ElPiloto/telescope-vimwiki.nvim', { 'for': 'wiki' }

" Rust
Plug 'rust-lang/rust.vim'

"Debug
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'

"Coverage
Plug 'andythigpen/nvim-coverage'

"Neotest
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python', { 'for': 'python' }
Plug 'rouge8/neotest-rust', { 'for': 'rust' }


call plug#end()

lua require("luasnip.loaders.from_vscode").lazy_load()
lua require("fidget").setup{}
