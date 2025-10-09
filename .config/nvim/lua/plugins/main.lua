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
      -- require("mini.pairs").setup()

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
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", function() require("telescope.builtin").find_files() end,            desc = "find files" },
      { "gs",    function() require("telescope.builtin").lsp_document_symbols() end,  desc = "find lsp document symbols" },
      { "gS",    function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "find lsp document symbols" },
      { "gf",    function() require("telescope.builtin").live_grep() end,             desc = "live grep" },
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = true,
    keys = {
      { "<C-n>", ":NvimTreeToggle<CR>", desc = "toggle file tree" }
    }
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
