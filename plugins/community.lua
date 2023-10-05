return {
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.motion.flash-nvim" },

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
