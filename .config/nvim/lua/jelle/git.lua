local map = require("jelle.utils").map

-- fugitive git bindings
-- http://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/

map("n", "<space>ga", ":Git add %:p<CR><CR>", { noremap = true })
map("n", "<space>ga", ":Git add %:p<CR><CR>", { noremap = true })
map("n", "<space>gs", ":Git<CR>", { noremap = true })
map("n", "<space>gc", ":Git commit -v -q<CR>", { noremap = true })
map("n", "<space>gt", ":Git commit -v -q %:p<CR>", { noremap = true })
map("n", "<space>gd", ":Gdiff<CR>", { noremap = true })
map("n", "<space>ge", ":Gedit<CR>", { noremap = true })
map("n", "<space>gr", ":Gread<CR>", { noremap = true })
map("n", "<space>gw", ":Gwrite<CR><CR>", { noremap = true })
map("n", "<space>gl", ":Gclog<CR>", { noremap = true, silent = true })
map("n", "<space>gp", ":Ggrep<Space>", { noremap = true })
map("n", "<space>gm", ":Gmove<Space>", { noremap = true })
map("n", "<space>gb", ":Git branch<Space>", { noremap = true })
map("n", "<space>go", ":Git checkout<Space>", { noremap = true })
map("n", "<space>gps", ":Git push<CR>", { noremap = true })
map("n", "<space>gpl", ":Git pull<CR>", { noremap = true })
map("n", "<space>gf", ":GFiles<CR>", { noremap = true })


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
    map('n', '<space>gR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<space>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
