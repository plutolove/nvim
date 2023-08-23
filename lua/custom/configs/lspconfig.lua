local base = require "plugins.configs.lspconfig"
local on_attach = base.on_attach
local capabilities = base.capabilities
local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    client.server_capabilities.semanticTokensProvider = nil
    on_attach(client, bufnr)
  end,
  cmd = {
    "clangd",
    "--log=verbose",
    "--pretty",
    "--all-scopes-completion",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--background-index",
    "--clang-tidy",
    "--clang-tidy-checks=cppcoreguidelines-*,performance-*,bugprone-*,portability-*,modernize-*,google-*",
    "-j=8",
    "--pch-storage=disk",
    "--function-arg-placeholders=true",
    "--compile-commands-dir=.vscode",
    "--query-driver=/usr/bin/clang++,/opt/cuda/bin/nvcc",
    "--offset-encoding=utf-16",
  },
  capabilities = capabilities
}
