local utils = require "user.utils"

return {
  { "akinsho/toggleterm.nvim", version = "*",                                           opts = { shell = "zsh" } },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {
      auto_refresh = true,
      search_venv_managers = true,
    },
    event = "VeryLazy",
    keys = { { "<leader>lv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup {
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
      }
      require("telescope").load_extension "undo"
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
  {
    "michaelb/sniprun",
    keys = {},
    opts = {},
    build = "bash ./install.sh 1",
    cmd = "SnipRun",
  },
  { "folke/which-key.nvim",    opts = { plugins = { presets = { operators = false } } } },
  {
    "mvllow/modes.nvim",
    version = "^0.2",
    event = "VeryLazy",
    opts = {
      colors = {
        copy = "#f5c359",
        delete = "#c75c6a",
        insert = "#78ccc5",
        visual = "#00ff99",
      },
    },
  },
  {
    "gbprod/cutlass.nvim",
    lazy = false,
    config = function()
      require("cutlass").setup {
        override_del = true,
        cut_key = "x",
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
  {
    -- todo! asdaa
    -- todo!() asdas
    -- FIXME: asdda
    -- FIXME! asda
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
          TODO = { icon = " ", color = "info", alt = { "todo" } },
        },
        merge_keywords = false,
        highlight = {
          comments_only = false,
          pattern = [[.*<(KEYWORDS)\s*([:\!])]],
        },
        search = {
          command = "rg",
          pattern = [[\b(KEYWORDS)([:!])]],
        },
      }
    end,
    event = "User AstroFile",
    cmd = { "TodoQuickFix", "TodoTelescope" },
    keys = {
      { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODOs in Telescope" },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    init = function() utils.list_insert_unique(astronvim.lsp.skip_setup, "rust_analyzer") end,
    config = function()
      local rt = require "rust-tools"
      local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
      local codelldb_path = package_path .. "/codelldb"
      local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
      local server = require("astronvim.utils.lsp").config "rust_analyzer"

      server = vim.tbl_deep_extend("force", server, {
        on_attach = function(client, bufnr) require("astronvim.utils.lsp").on_attach(client, bufnr) end,
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
            -- cargo = {
            --   loadOutDirsFromCheck = true,
            -- },
            -- assist = {
            --   importGranularity = "module",
            --   importPrefix = "by_self",
            -- },
          },
        },
      })

      rt.setup {
        tools = {
          autoSetHints = true,
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            max_len_align = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
          },
        },
        server = server,
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(
            codelldb_path,
            liblldb_path .. (vim.loop.os_uname().sysname == "Linux" and ".so" or ".dylib")
          ),
        },
      }
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
}
