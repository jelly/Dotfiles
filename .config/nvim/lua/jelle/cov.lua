local coverage = require("coverage")

local opts = { noremap=true, silent=true }
function keymap(key, fun)
	vim.keymap.set('n', key, fun, opts)
end

coverage.setup({
	auto_reload = true,
	commands = true,
	highlights = {
		-- customize highlight groups created by the plugin
		covered = { fg = "#C3E88D" },   -- supports style, fg, bg, sp (see :h highlight-gui)
		uncovered = { fg = "#F07178" },
	},
	signs = {
		-- use your own highlight groups or text markers
		covered = { hl = "CoverageCovered", text = "▎" },
		uncovered = { hl = "CoverageUncovered", text = "▎" },
	},
	summary = {
		min_coverage = 80.0
	},
	lang = {
	}
})

local loaded_covergae = false
local toggle_coverage = function()
	if not loaded_coverage then
		coverage.load(true)
		loaded_coverage = true
	end
	coverage.toggle()
end

keymap("<leader>dc", toggle_coverage)
