-- -----------
-- | OPTIONS |
-- -----------

local opt = vim.opt
local g = vim.g
local map = vim.keymap.set

-- disable netrw (required for nvim-tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- 24-bit terminal colors
opt.termguicolors = true

-- nice window borders
opt.winborder = "rounded"

-- indenting
opt.breakindent = true
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- other opts
opt.wrap = false
opt.scrolloff = 5
opt.mouse = "a"
opt.showmode = false
opt.undofile = true
opt.confirm = true
opt.completeopt = "menuone,noinsert,fuzzy,nosort"

-- filetypes
vim.filetype.add({
  extension = {
    md = "markdown",
    svx = "markdown"
  }
})

-- Open typst pdf with zathura
vim.api.nvim_create_user_command("TypstOpen", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if not filepath:match("%.typ$") then
    print("Not a typst file!")
    return
  end
  vim.fn.jobstart("zathura " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
end, {})

-- auto format control
vim.api.nvim_create_user_command("ConformDisable", function()
  g.conform_disable = true
end, {})

vim.api.nvim_create_user_command("ConformEnable", function()
  g.conform_disable = false
end, {})

-- configure in-editor diagnostic display
vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_lines = {
    current_line = true
  }
})

-- -----------
-- | PLUGINS |
-- -----------

local gh = function(x) return "https://github.com/" .. x end
vim.pack.add({
  gh("catppuccin/nvim"),
  gh("echasnovski/mini.nvim"),
  gh("windwp/nvim-autopairs"),
  gh("nvim-telescope/telescope.nvim"),
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-lualine/lualine.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("nmac427/guess-indent.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),
  gh("stevearc/oil.nvim")
})

vim.cmd.colorscheme "catppuccin-nvim"

require("nvim-autopairs").setup({})
require("lualine").setup()
require("gitsigns").setup()
require("oil").setup()

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require("mini.comment").setup()
require("mini.cursorword").setup()
require("mini.completion").setup()

-- mini surround keybind remapping
require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    find = "",
    find_left = "",
    highlight = "",
    replace = "cs",
    update_n_lines = "",
    suffix_last = "",
    suffix_next = "",
  },
  search_method = "cover_or_next",
})
vim.keymap.del("x", "ys")
map("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })
map("n", "yss", "ys_", { remap = true })

-- lsp settings
require("mason").setup()
require("mason-lspconfig").setup()
vim.lsp.config("tinymist", {
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType"
  }
})
vim.lsp.config("zls", {
  settings = {
    enable_build_on_save = true,
  }
})
-- config lsps not installed by mason
vim.lsp.enable("dartls")
vim.lsp.enable("zls")

-- ------------
-- | KEYBINDS |
-- ------------

-- god's keybind
map("i", "jj", "<Esc>")

-- completion accept
local map_accept_completion = function(key)
  map("i", key, function()
    -- If there is selected item in popup, accept it with <C-y>
    if vim.fn.complete_info()["selected"] ~= -1 then return "\25" end
    -- Fall back to plain `<CR>`. You might want to customize according
    -- to other plugins. For example if 'mini.pairs' is set up, replace
    -- next line with `return MiniPairs.cr()`
    return "\r"
  end, { expr = true })
end
map_accept_completion("<CR>")
map_accept_completion("<Tab>")

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

-- telescope binds
map("n", "<C-p>", function() require("telescope.builtin").find_files() end)
map("n", "gs", function() require("telescope.builtin").lsp_document_symbols() end)
map("n", "gS", function() require("telescope.builtin").lsp_workspace_symbols() end)
map("n", "gf", function() require("telescope.builtin").live_grep() end)

-- oil
map("n", "-", "<cmd>Oil --float<cr>")
