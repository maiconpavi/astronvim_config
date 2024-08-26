return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "User AstroFile",
    opts = {
      suggestion = {
        auto_trigger = true,
      },
      filetypes = {
        gotmpl = true,
        yaml = true,
        markdown = true,
        ["dap-repl"] = true,
        dapui_watches = true,
        dapui_hover = true,
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
    "aznhe21/actions-preview.nvim",
    event = { "User AstroFile" },
    config = function() vim.keymap.set({ "v", "n" }, "<leader>lA", require("actions-preview").code_actions) end,
  },
  {
    "klen/nvim-test",
    config = function() require("nvim-test").setup() end,
    lazy = false,
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = function(_, opts)
      -- disable dap events that are created
      local dap = require "dap"
      local venv_selector = require "venv-selector"
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = venv_selector.get_active_path,
        },
      }
      dap.adapters.python = {
        type = "executable",
        command = "/usr/bin/python3",
        args = { "-m", "debugpy.adapter" },
      }
      -- disable auto close
      dap.listeners.after.event_initialized["dapui_config"] = nil
      dap.listeners.before.event_terminated["dapui_config"] = nil
      dap.listeners.before.event_exited["dapui_config"] = nil
      -- enable auto completion for dap
    end,
  },
  {
    "olexsmir/gopher.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    ft = "go",
    opts = {},
  },
  {
    "michaelb/sniprun",
    keys = {},
    opts = {},
    build = "bash ./install.sh 1",
    cmd = "SnipRun",
  },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = function()
      local rt = require "rust-tools"
      local utils = require "astronvim.utils"
      local package_path = require("mason-registry").get_package("codelldb"):get_install_path()
      local codelldb_path = package_path .. "/codelldb"
      local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
      local server = require("astronvim.utils.lsp").config "rust_analyzer"
      local custom_server = {
        on_attach = function(client, bufnr) require("astronvim.utils.lsp").on_attach(client, bufnr) end,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              extraEnv = {
                RUSTFLAGS = "-Wclippy::pedantic -Wclippy::nursery -Wclippy::unwrap_used -Aclippy::module_name_repetitions",
              },
            },
            checkOnSave = true,
            check = {
              command = "clippy",
            },
            procMacro = {
              enable = true,
              ignored = {},
              attributes = {
                enable = true,
              },
            },
          },
        },
      }

      server = vim.tbl_deep_extend("force", server, custom_server)

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
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    opts = function(_, opts)
      -- use this function notation to build some variables
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
      local root_dir = require("jdtls.setup").find_root(root_markers)
      -- calculate workspace dir
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
      os.execute("mkdir " .. workspace_dir)

      -- get the current OS
      local os
      if vim.fn.has "mac" == 1 then
        os = "mac"
      elseif vim.fn.has "unix" == 1 then
        os = "linux"
      elseif vim.fn.has "win32" == 1 then
        os = "win"
      end

      -- ensure that OS is valid
      if not os or os == "" then
        require("astronvim.utils").notify("jdtls: Could not detect valid OS", vim.log.levels.ERROR)
      end

      local defaults = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. vim.fn.expand "$MASON/share/jdtls/lombok.jar",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.expand "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
          "-configuration",
          vim.fn.expand "$MASON/share/jdtls/config",
          "-data",
          workspace_dir,
        },
        root_dir = root_dir,
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                {
                  name = "JavaSE-19",
                  path = "/usr/lib/jvm/java-19-openjdk-amd64/",
                },
                {
                  name = "JavaSE-11",
                  path = "/usr/lib/jvm/java-11-openjdk-amd64/",
                },
              },
            },
            maven = {
              downloadSources = true,
            },

            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
          },
          signatureHelp = {

            enabled = true,
          },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
        init_options = {
          bundles = {
            vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
            -- unpack remaining bundles
            (table.unpack or unpack)(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
          },
        },
        handlers = {
          ["$/progress"] = function()
            -- disable progress updates.
          end,
        },
        filetypes = { "java" },
        on_attach = function(client, bufnr)
          require("jdtls").setup_dap {
            hotcodereplace = "auto",
          }
          require("astronvim.utils.lsp").on_attach(client, bufnr)
        end,
      }

      -- TODO: add overwrite for on_attach

      -- ensure that table is valid
      if not opts then opts = {} end

      -- extend the current table with the defaults keeping options in the user opts
      -- this allows users to pass opts through an opts table in community.lua
      opts = vim.tbl_deep_extend("keep", opts, defaults)

      -- send opts to config
      return opts
    end,
    config = function(_, opts)
      -- setup autocmd on filetype detect java
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "java", -- autocmd to start jdtls
        callback = function()
          if opts.root_dir and opts.root_dir ~= "" then
            require("jdtls").start_or_attach(opts)
            -- require('jdtls.dap').setup_dap_main_class_configs()
          else
            require("astronvim.utils").notify(
              "jdtls: root_dir not found. Please specify a root marker",
              vim.log.levels.ERROR
            )
          end
        end,
      })
      -- create autocmd to load main class configs on LspAttach.
      -- This ensures that the LSP is fully attached.
      -- See https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
      vim.api.nvim_create_autocmd("LspAttach", {
        pattern = "*.java",
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- ensure that only the jdtls client is activated
          if client.name == "jdtls" then require("jdtls.dap").setup_dap_main_class_configs() end
        end,
      })
    end,
  },
}
