local opt = vim.opt
local g = vim.g

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

vim.schedule(function() opt.clipboard = "unnamedplus" end)

-- filetypes
vim.filetype.add({
  extension = {
    md = "markdown"
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
