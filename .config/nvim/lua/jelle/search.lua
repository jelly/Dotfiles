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

local luasnip = require('telescope').load_extension('luasnip')
local lga_actions = require("telescope-live-grep-args.actions")

require('telescope').setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    file_ignore_patterns = {
	    "node_modules/"
    },
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
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = {
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-l>g"] = lga_actions.quote_prompt({ postfix = ' --iglob ' }),
          ["<C-l>t"] = lga_actions.quote_prompt({ postfix = ' -t' }),
        }
      }
    }
  }
})

local telescope = require('telescope.builtin')
local opts = { noremap=true, silent=true, buffer=bufnr }
local function keymap(key, fun)
	vim.keymap.set('n', key, fun, opts)
end

keymap('ff', telescope.find_files)
keymap('fg', require("telescope").extensions.live_grep_args.live_grep_args)
keymap('fb', telescope.buffers)
keymap('fh', telescope.help_tags)
keymap('fm', telescope.man_pages)
