" Inspiration:
" https://github.com/togglebyte/nvim/blob/a1e540af9ee591e5a9003a0230ecc8cea8fed1e3/after/ftplugin/rust.vim

nmap <C-b> :Compile<CR>
nmap <Leader>x :Cargo run<CR>
nmap <Leader>b :Cargo test -- --nocapture<CR>

nmap <F5> :call RunDebugger()<CR>
nmap <leader>d :Break<CR>
nmap <leader>r :Run<CR>
