"colorscheme wombat256mod
colorscheme candycode

set tags+=~/.vim/tags/cpp

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
autocmd BufRead,BufNewFile ~/.mutt/tmp/* set filetype=mail | set textwidth=72 | set spell |  set wrap | setlocal spell spelllang=nl

filetype plugin indent on

" Sprunge
" "-------------------------------
command -range=% Share :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us|xclip

" Remap Snipmate
" "--------------------------------
"ino <c-tab> <c-r>=TriggerSnippet()<cr>
"snor <c-tab> <esc>i<right><c-r>=TriggerSnippet()<cr>

" LaTeX Live Preview
" "--------------------------------
autocmd FileType tex silent :! (file="%"; pdflatex % &>/dev/null && zathura "${file/.tex/.pdf}" &>/dev/null) &
command! Reload :! (pdflatex % &>/dev/null) &
au BufWritePost *.tex silent Reload 
set spell
setlocal spell spelllang=nl
syntax on
if has('mouse')
  set mouse=a
endif

" GUI Options GVIM
set guioptions-=mrL

set cindent
set smartindent
set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set grepprg=grep\ -nH\ $*

"Supertab and Snipmate
let g:SuperTabDefaultCompletionType = "context"

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
