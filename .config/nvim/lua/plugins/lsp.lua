return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      -- custom options for specific lsps
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
    end
  },
  {
    "Saghen/blink.cmp",
    version = "*",
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "default",
          ["<Enter>"] = { "accept", "fallback" },
          ["<Tab>"] = { "accept", "fallback" }
        },
        appearance = {
          nerd_font_variant = "mono"
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        cmdline = {
          enabled = false
        },
        completion = {
          menu = {
            border = "single"
          },
          documentation = {
            auto_show = true,
            window = { border = "single" }
          }
        },
        signature = {
          enabled = true
        }
      })
    end
  }
}
