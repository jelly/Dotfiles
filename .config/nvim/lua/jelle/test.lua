local opts = { noremap=true, silent=true }
function keymap(key, fun, desc)
	opts.desc = desc
	vim.keymap.set('n', key, fun, opts)
end

local neotest = require("neotest")
neotest.setup({
  adapters = {
    require("neotest-python")({
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

local debug_test = function()
	neotest.run.run({ strategy = 'dap' })
end

keymap("<leader>dm", neotest.run.run, "Test method")
keymap("<leader>dM", debug_test, "Test method (with debugging)")
keymap("<leader>ds", neotest.summary.toggle, "Test Summary")
