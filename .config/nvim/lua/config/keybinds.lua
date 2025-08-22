local map = vim.keymap.set

-- god's keybind
map("i", "jj", "<Esc>")

-- lsp binds
map("n", "rn", function() vim.lsp.buf.rename() end)
map({ "v", "n" }, "ga", function() vim.lsp.buf.code_action() end)
map("n", "K", function() vim.lsp.buf.hover() end)

-- more sensible wrapped line navigation
map({ "v", "n" }, "j", "gj");
map({ "v", "n" }, "k", "gk");
map({ "v", "n" }, "gj", "j");
map({ "v", "n" }, "gk", "k");
