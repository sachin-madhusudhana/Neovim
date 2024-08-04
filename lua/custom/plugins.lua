
local plugins = {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "clangd",
      "pyright",
      },
    },
  },
  -- Add null-ls plugin
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.clang_check,
        },
      })
    end
  },
  -- Add nvim-cmp plugin
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Set up capabilities
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Your existing cmp setup code here... 
      -- Make capabilities available globally
      vim.g.lsp_capabilities = capabilities
    end
  },
  -- Add other custom plugins here
}

return plugins

