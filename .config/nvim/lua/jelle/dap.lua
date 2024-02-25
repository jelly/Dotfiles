local dap = require('dap')
local dapui = require("dapui")
local dap_python = require('dap-python')
local dap_virtual_text = require("nvim-dap-virtual-text")


dapui.setup()
dap_virtual_text.setup()

-- Dap UI configuration
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

local function keymap(key, fun)
	vim.keymap.set('n', key, fun, opts)
end

keymap('<F5>', dap.continue)
keymap('<F9>', dap.close)
keymap('<F10>', dap.continue)
keymap('<F11>', dap.step_over)
keymap('<F12>', dap.step_out)
keymap('<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
keymap('<leader>dd', dap.continue)


dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "-i", "dap" }
}

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}
