" Auto expand tabs to spaces (use space rather than tab)
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2

" Auto indent after a {
setlocal autoindent
setlocal smartindent

# Autformat on save using eslint
autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
