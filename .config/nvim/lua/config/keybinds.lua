local map = vim.keymap.set

-- god's keybind
map("i", "jj", "<Esc>")

-- lsp binds
map("n", "rn", vim.lsp.buf.rename)
map({ "v", "n" }, "ga", vim.lsp.buf.code_action)
map("n", "K", vim.lsp.buf.hover)
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.type_definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "ge", vim.diagnostic.setqflist)

-- qfl binds
map("n", "<M-j>", ":cnext<CR>")
map("n", "<M-k>", ":cprev<CR>")

-- more sensible wrapped line navigation
map({ "v", "n" }, "j", "gj");
map({ "v", "n" }, "k", "gk");
map({ "v", "n" }, "gj", "j");
map({ "v", "n" }, "gk", "k");
