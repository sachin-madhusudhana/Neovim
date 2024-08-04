--local on_attach = require("custom.configs.lspconfig").on_attach
--local capabilities = require("custom.configs.lspconfig").capabilities

local lsp_common = require("custom.configs.lsp_common")
local capabilities = vim.g.lsp_capabilities or vim.lsp.protocol.make_client_capabilities()

local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "pyright", "tsserver" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_common.on_attach,
    capabilities = capabilities,
  }
end

-- Explicit setup for clangd with Bazel support
lspconfig.clangd.setup {
  on_attach = lsp_common.on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--query-driver=/usr/bin/clang++", -- Adjust this path to your clang++ binary
    "--clang-tidy",
    "--all-scopes-completion",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern(
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "WORKSPACE",
    "BUILD",
    "BUILD.bazel",
    ".git"
  ),
  single_file_support = true,
}

