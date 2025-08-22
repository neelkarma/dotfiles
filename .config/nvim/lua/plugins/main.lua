return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        integrations = {
          blink_cmp = true,
          snacks = {
            enabled = true,
            indent_scope_color = "overlay0"
          }
        }
      })
      vim.cmd.colorscheme("catppuccin")
    end
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
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
      require("mini.pairs").setup()

      -- use vim-surround-like keymap
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

      -- Remap adding surrounding to Visual mode selection
      vim.keymap.del("x", "ys")
      vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })

      -- Make special mapping for "add surrounding for line"
      vim.keymap.set("n", "yss", "ys_", { remap = true })
    end
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    keys = {
      { "<C-n>", function() Snacks.explorer({ hidden = true }) end,     desc = "toggle explorer" },
      { "<C-p>", function() Snacks.picker.files({ hidden = true }) end, desc = "find files" },
      { "gs",    function() Snacks.picker.lsp_symbols() end,            desc = "find lsp document symbols" },
      { "gd",    function() Snacks.picker.lsp_definitions() end,        desc = "find lsp definitions" },
      { "gr",    function() Snacks.picker.lsp_references() end,         desc = "find lsp references" },
      { "gt",    function() Snacks.picker.lsp_type_definitions() end,   desc = "find lsp type definitions" },
      { "gf",    function() Snacks.picker.grep() end,                   desc = "live grep" },
      { "gm",    function() Snacks.picker.marks() end,                  desc = "find marks" },
      { "gv",    function() Snacks.lazygit() end,                       desc = "lazygit" },
    },
    config = function()
      require("snacks").setup({
        explorer = {},
        indent = {
          enabled = true,
          animate = { enabled = false }
        },
        picker = {},
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "ge", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "toggle trouble diagnostics" }
    },
    config = function()
      require("trouble").config()
    end
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_organize_imports", "ruff_format" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          markdown = { "prettier" },
          astro = { "prettier" },
          svelte = { "prettier" },
          yaml = { "prettier" },
          rust = { "rustfmt" }
        },
        format_on_save = function(bufnr)
          if vim.g.conform_disable then
            return
          end
          return {
            timeout_ms = 2000,
            lsp_format = "fallback"
          }
        end
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end
  },
  {
    "jiaoshijie/undotree",
    keys = {
      { "gh", function() require('undotree').toggle() end },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true
  },
  {
    "nvim-flutter/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = true
  },
  {
    "vyfor/cord.nvim",
    build = ":Cord update"
  }
}
