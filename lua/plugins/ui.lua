return {{"luc-tielen/telescope_hoogle"}, {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
        local status = require("astroui.status")
        opts.statusline = {
            hl = {
                fg = "fg",
                bg = "bg"
            },
            status.component.mode {
                mode_text = {
                    padding = {
                        left = 1,
                        right = 1
                    }
                }
            }, -- add the mode text
            status.component.git_diff(),
            status.component.diagnostics(),
            status.component.fill(),
            status.component.cmd_info(),
            status.component.fill(),
            status.component.lsp {
                lsp_progress = false,
                surround = {
                    separator = "right"
                }
            },
            status.component.nav {
                percentage = false,
                scrollbar = false
            }
        }

        return opts
    end
}, {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            signature = {
                enabled = false
            }
        }
        -- add any options here
    },
    dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim", -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify"}
}, {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
        render = "compact",
        stages = "fade",
        fps = "144",
        level = 3,
        timeout = 3
    }
}, {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        shell = "zsh"
    }
}, {
    "christoomey/vim-tmux-navigator",
    lazy = false
}, {
    "linux-cultist/venv-selector.nvim",
    dependencies = {"neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim"},
    opts = {
        auto_refresh = true,
        search_venv_managers = false,
        search = true,
        search_workspace = true,
        parents = 0
    },
    lazy = false
}, {
    "sudormrfbin/cheatsheet.nvim",
    lazy = false,
    requires = {{"nvim-telescope/telescope.nvim"}, {"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
}, {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
        require("trouble").setup {}
    end
}, {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim"},
    config = function()
        local actions = require "telescope.actions"
        local get_icon = require("astroui").get_icon
        require("telescope").setup {
            defaults = {
                file_ignore_patterns = {"node_modules"},
                git_worktrees = vim.g.git_worktrees,
                prompt_prefix = string.format("%s ", get_icon "Search"),
                selection_caret = string.format("%s ", get_icon "Selected"),
                path_display = {"smart"},
                sorting_strategy = "ascending",
                layout_strategy = "vertical",
                layout_config = {
                    anchor = "N",
                    horizontal = {
                        prompt_position = "top"
                    },
                    vertical = {
                        mirror = false,
                        preview_height = 0.6
                    },
                    width = 0.87,
                    height = 0.90,
                    mirror = false
                },

                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous
                    },
                    n = {
                        ["q"] = actions.close
                    }
                }
            },
            extensions = {
                undo = {
                    -- telescope-undo.nvim config, see below
                }
            }
        }
        require("telescope").load_extension "undo"
    end
}, {
    "NvChad/nvim-colorizer.lua",
    enabled = false
}, {
    "uga-rosa/ccc.nvim",
    version = "*",
    event = "User AstroFile",
    keys = {{
        "<leader>uC",
        "<cmd>CccPick<cr>",
        desc = "Toggle colorizer"
    }},
    opts = {
        highlighter = {
            auto_enable = true
        }
    },
    config = function(_, opts)
        local ccc = require "ccc"
        opts.highlighter = {
            auto_enable = true,
            lsp = true
        }

        ccc.setup(opts)
    end
}, {
    "folke/which-key.nvim",
    opts = {
        plugins = {
            presets = {
                operators = false
            }
        }
    }
}, {
    "mvllow/modes.nvim",
    version = "^0.2",
    event = "VeryLazy",
    opts = {
        colors = {
            copy = "#f5c359",
            delete = "#c75c6a",
            insert = "#78ccc5",
            visual = "#00ff99"
        }
    }
}}
