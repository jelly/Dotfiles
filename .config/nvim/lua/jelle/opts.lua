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

-- Leader
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 24 bit colors
vim.o.termguicolors = true

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Theme
vim.cmd.colorscheme('tokyonight')

local function update_theme()
	vim.fn.jobstart({ 'gsettings', 'get', 'org.gnome.desktop.interface', 'color-scheme'}, {
		stdout_buffered = true,
		on_stdout = function(_, data)
			if data then
				theme = table.concat(data)
				if theme == "'prefer-dark'" then
					vim.opt.background = 'dark'
				else
					vim.opt.background = 'light'
				end
			end
		end
	})
end

update_theme()

vim.api.nvim_create_autocmd("Signal", { pattern = { "*" }, callback = update_theme })
