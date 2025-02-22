nmap <Leader>x :Cargo run<CR>
nmap <Leader>c :Cargo clippy<CR>

let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }
let g:rustfmt_autosave = 1
