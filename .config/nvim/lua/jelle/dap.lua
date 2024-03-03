local dap = require('dap')
local dapui = require("dapui")
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

dap.adapters.rust_gdb = {
  type = "executable",
  command = "rust-gdb",
  args = { "-i", "dap" }
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "rust_gdb",
    request = "launch",
    program = function()
      -- cargo metadata --no-deps --format-version 1 | jq -r '[.packages[].targets[] | select(.kind | index("bin"))][0] | .name'
      -- cargo metadata --format-version 1 --no-deps | jq | jq .workspace_root
      local output = vim.fn.system("cargo metadata --no-deps --format-version 1 | jq -r '[.packages[].targets[] | select(.kind | index(\"bin\"))][0] | .name'")
      -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/' .. output, 'file')
      return vim.fn.getcwd() .. '/target/debug/' .. output
    end,
    args = function()
      local args_string = vim.fn.input("Arguments: ") return vim.split(args_string, " ")
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
}

dap.adapters.python = {
  type = 'executable';
  command = "/usr/bin/python";
  args = { '-m', 'debugpy.adapter' };
}


dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";
    cwd = "${workspaceFolder}",

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
        return '/usr/bin/python'
    end;
  },
}
