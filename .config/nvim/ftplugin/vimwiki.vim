" notes
nnoremap <F1> :terminal make serve<CR>
nnoremap <F2> :!make rsync_upload<CR>
nnoremap <F3> :!make commit_push<CR>
nnoremap <F4> :VimwikiTabMakeDiaryNote<CR>

command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

au BufNewFile ~/Notes/diary/*.md :silent 0r !~/bin/generate-vimwiki-diary-template '%'
