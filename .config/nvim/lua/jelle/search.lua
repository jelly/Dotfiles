-- Yanks the shown preview line
local yank_selection = function(prompt_bufnr)
    local action_state = require "telescope.actions.state"
    local actions = require "telescope.actions"
    local content = action_state.get_selected_entry()
    if content == nil then
        return
    end
    vim.fn.setreg('', content["text"])
end

require('telescope').setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    vimgrep_arguments = { "rg", "--color=never", "--no-heading",
  			"--with-filename", "--line-number", "--column", "--smart-case", "--glob=!node_modules/*", },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
	["<C-y>"] = yank_selection
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
})

local telescope = require('telescope.builtin')
local opts = { noremap=true, silent=true, buffer=bufnr }
local function keymap(key, fun)
	vim.keymap.set('n', key, fun, opts)
end

keymap('ff', telescope.find_files)
keymap('fg', telescope.live_grep)
keymap('fb', telescope.buffers)
keymap('fh', telescope.help_tags)
keymap('fm', telescope.man_pages)
