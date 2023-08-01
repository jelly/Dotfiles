" Inspiration:
" https://github.com/togglebyte/nvim/blob/a1e540af9ee591e5a9003a0230ecc8cea8fed1e3/after/ftplugin/rust.vim

nmap <C-b> :Compile<CR>
nmap <Leader>x :Cargo run<CR>
nmap <Leader>b :Cargo test -- --nocapture<CR>
nmap <Leader>c :Cargo clippy<CR>

nmap <F5> :call RunDebugger()<CR>
nmap <leader>d :Break<CR>
nmap <leader>r :Run<CR>

nmap <F1> :Run<CR>
nmap <F2> :Step<CR>
nmap <F3> :Over<CR>
nmap <F4> :Stop<CR>

let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
let g:rustfmt_autosave = 1
