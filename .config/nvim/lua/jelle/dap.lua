local dap = require('dap')
local dap_python = require('dap-python')

local function keymap(key, fun)
	vim.keymap.set('n', key, fun, opts)
end

keymap('<F5>', dap.continue)
keymap('<leader>dd', dap.continue)
keymap('<F10>', dap.continue)
keymap('<F11>', dap.step_over)
keymap('<F12>', dap.step_out)
keymap('<leader>b', dap.toggle_breakpoint)
-- keymap('<leader>B', dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')))
-- keymap('<leader>dr', dap.repl.open)
-- keymap('<leader>dr', dap.repl.run_last)
-- keymap('<leader>dn', dap_python.test_method)
-- keymap('<leader>ds', dap_python.debug_selection)
