let python_highlight_all = 1
let python_slow_sync = 1

set expandtab shiftwidth=4 softtabstop=4
set completeopt=preview

let g:ale_linters = {
\   'python': ['flake8', 'pyls', 'bandit', 'mypy'],
\}

let g:ale_python_pyls_config = {
\   'pyls': {
\     'plugins': {
\       'pycodestyle': {
\         'enabled': v:false,
\       },
\       'pyflakes': {
\         'enabled': v:false,
\       },
\       'pydocstyle': {
\         'enabled': v:false,
\       },
\     },
\   },
\}
