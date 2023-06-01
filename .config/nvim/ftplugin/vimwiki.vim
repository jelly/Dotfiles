" notes
nnoremap <F1> :terminal make serve<CR>
nnoremap <F2> :!make rsync_upload<CR>
nnoremap <F3> :!make commit_push<CR>
nnoremap <F4> :VimwikiTabMakeDiaryNote<CR>
nnoremap <F5> :tabnew \| :VimwikiDiaryIndex<CR>

command! Diary VimwikiDiaryIndex
autocmd BufRead,BufNewFile ~/Notes/diary/diary.md VimwikiDiaryGenerateLinks

au BufNewFile ~/Notes/diary/*.md :silent 0r !~/bin/generate-vimwiki-diary-template '%'
au BufRead,BufNewFile ~/Notes/diary/*.md Gwrite

function g:LocalIndex()
  let route=substitute(expand("%:h"), '^.*/', '', '') . "/*.md"
  execute "VimwikiGenerateLinks" . " " . route 
endfun

let g:auto_generate_links=1
autocmd BufEnter *index.md :call LocalIndex()
