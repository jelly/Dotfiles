-- fugitive git bindings
-- http://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/
local opts = { noremap=true, silent=true }
function keymap(key, fun)
	vim.keymap.set('n', key, fun, opts)
end

local telescope = require('telescope.builtin')

keymap("<leader>gb", ":Git blame<CR>")
keymap("<leader>gt", ":Git commit -v -q %:p<CR>")
keymap("<leader>gd", ":Gdiff<CR>")
keymap("<leader>ge", ":Gedit<CR>")

-- Rebase in le neovim
-- TODO: don't hardcode main, but use git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
keymap("<leader>grm", ":Git rebase -i main<CR>")
keymap("<leader>grc", ":Git rebase --continue<CR>")
keymap("<leader>ga", ":Git commit --amend %:p<CR><CR>")

keymap("<leader>gw", ":Gwrite<CR><CR>")
keymap("<leader>gl", ":Gclog<CR>")
keymap("<leader>gm", ":Gmove<Space>")
keymap("<leader>go", ":Git checkout<Space>")
keymap("<leader>gps", ":Git push<CR>")
keymap("<leader>gpl", ":Git pull<CR>")
keymap("<F1>", ":! updategitfork<CR>")
keymap("<leader>gu", ":! updategitfork<CR>")

keymap('<leader>gc', telescope.git_branches)
keymap('<leader>gf', telescope.git_files)
keymap('<leader>gl', telescope.git_commits)
keymap("<leader>gs", telescope.git_status)


require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>gR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

-- Set spelllang in git commit messages
vim.cmd([[
autocmd FileType gitcommit setlocal spell
]])
