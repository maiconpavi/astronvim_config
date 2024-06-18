-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff_lsp",
        "taplo",
        "rust_analyzer",
        "gopls",
        "prismals",
        "graphql",
        "docker_compose_language_service",
        "dockerls",
        "jdtls",
        "lemminx",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      handlers = {
        taplo = function() end,
      },
      ensure_installed = {
        "sql-formatter",
        "prettier",
        "eslint-lsp",
        "stylua",
        "rustfmt",
        "isort",
        "black",
        "cfn-lint",
        "yamllint",
        "gomodifytags",
        "gofumpt",
        "iferr",
        "impl",
        "goimports",
        "hadolint",
        "clang_format",
      },
    },
  },
  -- use mason-nvim-dap to configure DAP (Debug Adapter Protocol) installation
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "python", "delve" }, -- "javadbg", "javatest"
    },
  },
}
