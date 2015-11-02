"colors
colorscheme jellybeans

set nocompatible
filetype off

" vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'bling/vim-airline'

" Snippets
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'

" Git integration
Bundle 'tpope/vim-fugitive'
" Xdebug integration
Bundle 'joonty/vdebug.git' 
Bundle 'tpope/vim-surround'

" Tagbar
Bundle 'majutsushi/tagbar'

" PHPComplete
Bundle 'shawncplus/phpcomplete.vim'

" Multi-line commenting
Bundle 'scrooloose/nerdcommenter'

call vundle#end()
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


" Sprunge
" -------------------------------
command -range=% Share :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip

" YouCompleteMe
" -------------------------------
let g:ycm_key_list_previous_completion=['<Up>']
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \   'html': ['<'],
  \   'css': ['.'],
  \ }

" Search
" -------------------------------
set hlsearch

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets        = "<c-l>" "List possible snippets based on current file
let g:UltiSnipsUsePythonVersion=2

" RST Live Preview
" --------------------------------
autocmd FileType rst silent :! (file="%"; rst2pdf % &>/dev/null && evince "${file/.rst/.pdf}" &>/dev/null) &
command! Reload :! (rst2pdf  % &>/dev/null) &
au BufWritePost *.rst silent Reload

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

" Tagbar
" ------------------------------
nmap <F8> :TagbarToggle<CR>

syntax on

" Mouse
if has('mouse')
  set mouse=a
endif

" GUI Options GVIM
set guioptions-=mrL

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

" Tags
set tags=./tags,tags;$HOME
