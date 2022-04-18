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
