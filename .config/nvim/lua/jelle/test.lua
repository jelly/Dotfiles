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
    }),
    -- Requires: cargo-nextest
    require("neotest-rust")({
    }),
  }
})

keymap("<leader>dm", neotest.run.run, "Test method")
keymap("<leader>dM", function() neotest.run.run({ strategy = 'dap' }) end, "Test method (with debugging)")
keymap("<leader>dF", function() neotest.run.run(vim.fn.expand("%")) end, "Run all tests in the current file")
keymap("<leader>ds", neotest.summary.toggle, "Test Summary")
