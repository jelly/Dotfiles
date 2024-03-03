" Inspiration:
" https://github.com/togglebyte/nvim/blob/a1e540af9ee591e5a9003a0230ecc8cea8fed1e3/after/ftplugin/rust.vim

nmap <C-b> :Compile<CR>
nmap <Leader>x :Cargo run<CR>
nmap <Leader>c :Cargo clippy<CR>

nmap <leader>r :Run<CR>

let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
let g:rustfmt_autosave = 1
