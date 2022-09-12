require("tokyonight").setup({
  style = "night",
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { italic = true},
  },
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end
})

vim.cmd[[colorscheme tokyonight]]

-- Leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 24 bit colors
vim.o.termguicolors = true
