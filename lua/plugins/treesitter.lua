-- Customize Treesitter
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "sql",
        "yaml",
        "json",
        "go",
        "python",
        "toml",
        "rust",
        "prisma",
        "graphql",
        "dockerfile",
        "java",
        "html",
        "gotmpl",
        "helm",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
    },
  },
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
    cmd = { "RainbowDelim", "RainbowDelimSimple", "RainbowDelimQuoted", "RainbowMultiDelim" },
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown", "norg", "org", "rmd" },
    opts = {},
  },
  {
    -- todo: asdaa
    -- todo!() asdas
    -- FIXME: asdda
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      require("todo-comments").setup {
        signs = false,
        keywords = {
          FIX = {
            icon = " ",
            color = "error",
            alt = { "FIXME", "BUG" },
          },
          TODO = {
            icon = " ",
            color = "info",
            alt = { "todo" },
          },
        },
        merge_keywords = false,
        highlight = {
          comments_only = true,
          pattern = [[.*<(KEYWORDS)\s*:]],
        },
        search = {
          command = "rg",
          pattern = [[\b(KEYWORDS):]],
        },
      }
    end,
    event = "User AstroFile",
    cmd = { "TodoQuickFix", "TodoTelescope" },
  },
}
