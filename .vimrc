"colors
colorscheme jellybeans

call plug#begin('~/.vim/plugged')

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'w0rp/ale'

Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git integration
Plug 'tpope/vim-fugitive'

" Xdebug integration
Plug 'joonty/vdebug', { 'for': 'php' }

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Tagbar
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" Completion
Plug 'maralla/completor.vim', {'do': 'make js'}

" Shows git diff in a sign column
Plug 'airblade/vim-gitgutter'

Plug 'mileszs/ack.vim'

Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on

" Autocmd options
" "--------------------------------
autocmd BufReadPost *.doc silent %!antiword "%" 
autocmd BufWriteCmd *.doc set readonly
autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufWriteCmd *.odt set readonly
autocmd BufReadPost *.pdf  silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
autocmd BufWriteCmd *.pdf set readonly
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.rtf set readonly
autocmd BufRead,BufNewFile ~/.mutt/tmp/* set filetype=mail | set textwidth=72 | set spell |  set wrap | setlocal spell spelllang=nl,en

" Completor.vim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Fix php_sync_method undefined
let php_sync_method=-1

" Search
" -------------------------------
set hlsearch

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets        = "<c-l>" "List possible snippets based on current file

" fugitive git bindings
" http://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Git push<CR>
nnoremap <space>gpl :Git pull<CR>

" Vim-airline
" -------------------------------

let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'jellybeans'
let g:airline_skip_empty_sections = 1

syntax on

" Mouse
if has('mouse')
  set mouse=a
endif

" GUI Options GVIM
set guioptions-=mrL

" Set max tabs to 20
set tabpagemax=20

set pastetoggle=<F12>

" indenting
set cindent
set smartindent
set autoindent
set complete+=s

" Spell
set spell spelllang=nl,en
set nospell
let g:tex_comment_nospell= 1

" Python stuff
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4
autocmd FileType python set completeopt=preview

" PKGBUILD stuff
autocmd FileType PKGBUILD set expandtab shiftwidth=2 softtabstop=4
"
" sh stuff
autocmd FileType sh set expandtab shiftwidth=2 softtabstop=4 

" html
autocmd Filetype html setlocal ts=2 sts=2 sw=2

" LaTeX
autocmd Filetype tex,latex set grepprg=grep\ -nH\ $
autocmd Filetype tex,latex setlocal spell 
autocmd Filetype tex,latex set grepprg=grep\ -nH\ $
autocmd Filetype tex,latex let g:tex_flavor = "latex"

" Vim-debug
" ------------------------------
let g:vdebug_options = { "break_on_open" : 0, }

" ALE
" ------------------------------
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['✘ %d', '⚠ %d', '']
let g:airline_section_error = '%{ALEGetStatusLine()}'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline#extensions#tagbar#enabled = 0

highlight clear ALEErrorSign

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ack.vim, fuzzy find
nnoremap <space>ff :Ack!<Space>
nnoremap <space>\\ :NERDTreeToggle<CR>
nnoremap <space>tt :TagbarToggle<CR>

" format json
nnoremap <space>json :%! python -m json.tool<CR>

" Use pacman -S the_silver_searcher if avaliable.
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let status = system('git status')
if shell_error == 0
	let g:ackprg = 'git grep -Hni'
endif
" Tags
set tags=./tags,tags;$HOME
