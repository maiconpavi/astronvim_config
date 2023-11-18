return {
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.java" },
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   opts = {
  --     settings = {
  --       java = {
  --         configuration = {
  --           runtimes = {
  --             {
  --               name = "JavaSE-19",
  --               path = "/usr/lib/jvm/java-19-openjdk-amd64/",
  --             },
  --             {
  --               name = "JavaSE-11",
  --               path = "/usr/lib/jvm/java-11-openjdk-amd64/",
  --             },
  --             {
  --               name = "JDK-21",
  --               path = "/usr/lib/jvm/jdk-21-oracle-x64/",
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  -- { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.toml" },

  -- color
  -- { import = "astrocommunity.color.twilight-nvim" },
  -- { import = "astrocommunity.color.ccc-nvim" },

  -- colorschemes
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.colorscheme.oxocarbon-nvim" },
  { import = "astrocommunity.colorscheme.dracula-nvim" },
}
