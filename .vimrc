"colors
colorscheme jellybeans

call plug#begin('~/.vim/plugged')

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'dense-analysis/ale'

" style
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Shows git diff in a sign column
Plug 'airblade/vim-gitgutter'

" Git integration
Plug 'tpope/vim-fugitive'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Completion
Plug 'maralla/completor.vim', {'do': 'make js'}

" search tool
Plug 'mileszs/ack.vim'

" formatting
Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'

Plug 'vimwiki/vimwiki', {'on' : ['VimwikiIndex', 'VimwikiUISelect'], 'for': 'wiki' }

Plug 'rust-lang/rust.vim'
Plug 'togglebyte/togglerust', { 'branch': 'main' }

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on

" Debug support
packadd termdebug

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
nnoremap <space>gs :Git<CR>
nnoremap <space>gc :Git commit -v -q<CR>
nnoremap <space>gt :Git commit -v -q %:p<CR>
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

" notes
nnoremap <F1> :terminal make serve<CR>
nnoremap <F2> :!make rsync_upload<CR>

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

" set filetype of PKGBUILD
augroup pkgbuild
    autocmd!
    autocmd BufRead,BufNewFile PKGBUILD set filetype=PKGBUILD
augroup END

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

" yaml
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

" ALE
" ------------------------------
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['✘ %d', '⚠ %d', '']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1

nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences<CR>
nmap R :ALERename<CR>
nmap K :ALEHover<CR>

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Gitgutter
autocmd BufWritePost * GitGutter
let g:gitgutter_log=1
let s:grep_available=0

highlight clear ALEErrorSign

" completor
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ack.vim, fuzzy find
nnoremap <space>ff :Ack!<Space>
nnoremap <space>\\ :NERDTreeToggle<CR>

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

"{{{3 vimwiki:main
let main_wiki = {}
let main_wiki.path = '~/Notes/'
let main_wiki.path_html = '~/.cache/vimwiki/main/html'
let main_wiki.automatic_nested_syntaxes = 1
let main_wiki.list_margin = 0
let main_wiki.ext = '.md'
let main_wiki.syntax = 'markdown'
" TODO: https://cristianpb.github.io/blog/vimwiki-hugo
let main_wiki.custom_wiki2html = '$HOME/bin/wiki2html.sh'
let main_wiki.template_ext = '.html'
"}}}
"{{{3 vimwiki:blog
let blog_wiki = {}
let blog_wiki.path = '~/projects/website/'
let blog_wiki.automatic_nested_syntaxes = 1
let blog_wiki.list_margin = 0
let blog_wiki.ext = '.md'
let blog_wiki.syntax = 'markdown'
"}}}
"{{{ vimwiki
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_use_calendar=1
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_folding = ''
let g:vimwiki_list = [main_wiki, blog_wiki]
"}}}
