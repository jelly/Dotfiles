require'nvim-treesitter'.setup {
  ensure_installed = { "c", "javascript", "rust", "python" },
  highlight = { enable = true },
  sync_install = false,
  indent = { enable = true },
}
