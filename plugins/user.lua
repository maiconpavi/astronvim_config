local utils = require "user.utils"

return {
  { "akinsho/toggleterm.nvim", version = "*", opts = { shell = "zsh" } },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    opts = {
      auto_refresh = true,
      search_venv_managers = true,
    },
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
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
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    opts = {
      suggestion = { auto_trigger = true, debounce = 150 },
      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    opts = function(_, opts)
      local cmp, copilot = require "cmp", require "copilot.suggestion"
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      if not snip_status_ok then return end
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end
      if not opts.mapping then opts.mapping = {} end
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if copilot.is_visible() then
          copilot.accept()
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<C-x>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.next() end
      end)

      opts.mapping["<C-z>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.prev() end
      end)

      opts.mapping["<C-right>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
      end)

      opts.mapping["<C-l>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_word() end
      end)

      opts.mapping["<C-down>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
      end)

      opts.mapping["<C-j>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.accept_line() end
      end)

      opts.mapping["<C-c>"] = cmp.mapping(function()
        if copilot.is_visible() then copilot.dismiss() end
      end)

      return opts
    end,
  },
  {
    "michaelb/sniprun",
    keys = {},
    opts = {},
    build = "bash ./install.sh 1",
    cmd = "SnipRun",
  },
  { "folke/which-key.nvim", opts = { plugins = { presets = { operators = false } } } },
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
