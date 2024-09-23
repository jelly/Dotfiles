vim.cmd("source ~/.config/nvim/plugins.vim")

require("jelle.opts")
require("jelle.tree")
require("jelle.search")
require("jelle.git")
require("jelle.lsp")
require("jelle.cmp")
require("jelle.treesitter")
require("jelle.statusline")
require("jelle.vimwiki")
require("jelle.dap")
require("jelle.cov")
require("jelle.test")

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
