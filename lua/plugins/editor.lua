return {
  {
    "smoka7/multicursors.nvim",
    event = "BufEnter",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {
      generate_hints = {
        normal = true,
        insert = true,
        extend = true,
      },
    },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
  {
    "matze/vim-move",
    event = "BufEnter",
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recomended as each new version will have breaking changes
    opts = {
      --Config goes here
    },
  },
  {
    "nvim-pack/nvim-spectre",
    lazy = false,
    version = "*",
    requires = "nvim-lua/plenary.nvim",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      local prefix = "<leader>s"
      require("nvim-surround").setup {
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = prefix .. "s",
          normal_cur = prefix .. "c",
          normal_line = prefix .. "S",
          normal_cur_line = prefix .. "C",
          visual = prefix .. "s",
          visual_line = prefix .. "S",
          delete = prefix .. "d",
          change = prefix .. "c",
        },
      }
    end,
  },
  {
    "gbprod/cutlass.nvim",
    event = { "User AstroFile" },
    config = function()
      require("cutlass").setup {
        override_del = true,
        cut_key = "x",
        excludes = {
          "ns",
          "nS",
        },
      }
    end,
  },
  {
    "johmsalas/text-case.nvim",
    event = "BufRead",
    config = function()
      require("textcase").setup {}
      require("telescope").load_extension "textcase"
    end,
  },
}
