local map = vim.keymap.set

map("n", "j", "j<CR><C-w>p", { buffer = true })
map("n", "k", "k<CR><C-w>p", { buffer = true })
map("n", "gg", "gg<CR><C-w>p", { buffer = true })
map("n", "G", "G<CR><C-w>p", { buffer = true })
