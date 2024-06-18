-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
---@type LazySpec
return {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
        -- Configure core features of AstroNvim
        features = {
            large_buf = {
                size = 1024 * 256,
                lines = 10000
            }, -- set global limits for large files for disabling features like treesitter
            autopairs = true, -- enable autopairs at start
            cmp = true, -- enable completion at start
            diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
            highlighturl = true, -- highlight URLs at start
            notifications = true -- enable notifications at start
        },
        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {
            virtual_text = true,
            underline = true
        },
        -- vim options can be configured here
        options = {
            opt = { -- vim.opt.<key>
                relativenumber = true, -- sets vim.opt.relativenumber
                number = true, -- sets vim.opt.number
                spell = false, -- sets vim.opt.spell
                signcolumn = "yes", -- sets vim.opt.signcolumn to yes
                wrap = false, -- sets vim.opt.wrap
                shell = "/usr/bin/zsh",
                title = true,
                titlestring = "%{v:progname} %{substitute(getcwd(), '^.*/', '', '')}"
            },
            g = { -- vim.g.<key>
                -- configure global vim variables (vim.g)
                -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
                -- This can be found in the `lua/lazy_setup.lua` file
                move_key_modifier = "A",
                move_key_modifier_visualmode = "A",
                autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
                cmp_enabled = true, -- enable completion at start
                autopairs_enabled = true, -- enable autopairs at start
                diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
                icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
                ui_notifications_enabled = true, -- disable notifications when toggling UI elements
                markdown_fenced_languages = {"ts=typescript"}
            }
        },
        -- Mappings can be configured through AstroCore as well.
        -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
        mappings = {
            -- first key is the mode
            n = {
                ["<Up>"] = {
                    "<Nop>",
                    desc = "Disable Up"
                },
                ["<Down>"] = {
                    "<Nop>",
                    desc = "Disable Down"
                },
                ["<Left>"] = {
                    "<Nop>",
                    desc = "Disable Left"
                },
                ["<Right>"] = {
                    "<Nop>",
                    desc = "Disable Right"
                },
                --- Tmux navigation
                ["C-h"] = {
                    "<cmd>TmuxNavigateLeft<cr>",
                    desc = "Tmux Navigate Left"
                },
                ["C-j"] = {
                    "<cmd>TmuxNavigateDown<cr>",
                    desc = "Tmux Navigate Down"
                },
                ["C-k"] = {
                    "<cmd>TmuxNavigateUp<cr>",
                    desc = "Tmux Navigate Up"
                },
                ["C-l"] = {
                    "<cmd>TmuxNavigateRight<cr>",
                    desc = "Tmux Navigate Right"
                },

                -- Text Case
                ["ga."] = {
                    "<cmd>TextCaseOpenTelescope<CR>",
                    desc = "TextCase Telescope"
                },
                ["gaS"] = {
                    function()
                        require("textcase").lsp_rename "to_snake_case"
                    end,
                    desc = "LSP rename to_snake_case"
                },
                ["gas"] = {
                    function()
                        require("textcase").current_word "to_snake_case"
                    end,
                    desc = "Convert to_snake_case"
                },

                -- Trouble
                ["<Leader>x"] = {
                    name = " Trouble"
                },
                ["<Leader>xw"] = {
                    "<cmd>TroubleToggle workspace_diagnostics<cr>",
                    desc = "Trouble Workspace Toggle"
                },
                ["<Leader>xd"] = {
                    "<cmd>TroubleToggle document_diagnostics<cr>",
                    desc = "Trouble Document Toggle"
                },
                ["<Leader>xq"] = {
                    "<cmd>TroubleToggle quickfix<cr>",
                    desc = "Trouble QuickFix Toggle"
                },
                ["<Leader>U"] = {
                    "<cmd>Telescope undo<cr>",
                    desc = "Undo Tree"
                },
                ["<Leader>lT"] = {
                    "<cmd>TestNearest<cr>",
                    desc = "Test Nearest"
                },
                ["<Leader>s"] = {
                    name = " Surround"
                },
                ["<Leader>fT"] = {
                    "<cmd>Find TODO's<cr>",
                    desc = "Open TODOs in Telescope"
                },

                -- Cargo commands
                ["<Leader>lg"] = {
                    name = " Cargo"
                },
                ["<Leader>lgf"] = {
                    "<cmd>! cargo fix --allow-dirty --allow-staged --allow-no-vcs --workspace<cr>",
                    desc = "Cargo Fix"
                },
                ["<Leader>lgt"] = {
                    "<cmd>terminal cargo test<cr>",
                    desc = "Cargo Test"
                },
                ["<Leader>lgT"] = {
                    "<cmd>terminal cargo test --workspace<cr>",
                    desc = "Cargo Test Workspace"
                },

                -- Python commands
                ["<Leader>lp"] = {
                    name = " Python"
                },
                ["<Leader>lpr"] = {
                    "<cmd>terminal python3 %<cr>",
                    desc = "Run Python File"
                },
                ["<Leader>lpt"] = {
                    "<cmd>terminal echo $(pwd)<cr>",
                    desc = "test"
                },

                -- Buffer
                ["<Leader>b"] = {
                    name = "Buffers"
                },
                ["<Leader>bn"] = {
                    "<cmd>tabnew<cr>",
                    desc = "New tab"
                },
                ["<Leader>bw"] = {
                    "<cmd>ToggleWrapMode<cr>",
                    desc = "Toggle Wrap Mode"
                },
                ["<Leader>bD"] = {
                    function()
                        require("astroui.status").heirline.buffer_picker(function(bufnr)
                            require("astronvim.utils.buffer").close(bufnr)
                        end)
                    end,
                    desc = "Pick to close"
                },
                ["<Leader>bS"] = {
                    ":wa!<cr>",
                    desc = "Save All Buffers"
                },

                -- Aerial
                ["[S"] = {
                    function()
                        require("aerial").prev_up(vim.v.count > 0 and vim.v.count or 1)
                    end,
                    desc = "Previous [count] Symbol in Tree"
                },
                -- find in files
                ["<Leader>fS"] = {
                    function()
                        require("spectre").open()
                    end,
                    desc = "Open Spectre"
                },
                -- second key is the lefthand side of the map

                -- navigate buffer tabs
                ["]b"] = {
                    function()
                        require("astrocore.buffer").nav(vim.v.count1)
                    end,
                    desc = "Next buffer"
                },
                ["[b"] = {
                    function()
                        require("astrocore.buffer").nav(-vim.v.count1)
                    end,
                    desc = "Previous buffer"
                },

                -- mappings seen under group name "Buffer"
                ["<Leader>bd"] = {
                    function()
                        require("astroui.status.heirline").buffer_picker(function(bufnr)
                            require("astrocore.buffer").close(bufnr)
                        end)
                    end,
                    desc = "Close buffer from tabline"
                }

                -- tables with just a `desc` key will be registered with which-key if it's installed
                -- this is useful for naming menus
                -- ["<Leader>b"] = { desc = "Buffers" },

                -- setting a mapping to false will disable it
                -- ["<C-S>"] = false,
            },
            t = {
                ["<C-n>"] = {
                    "<C-\\><C-n>",
                    desc = "Exit Terminal Mode"
                }
            },
            v = {
                -- Text Case
                ["ga."] = {
                    "<cmd>TextCaseOpenTelescope<CR>",
                    desc = "TextCase Telescope"
                },
                ["gas"] = {
                    function()
                        require("textcase").current_word "to_snake_case"
                    end,
                    desc = "Convert to_snake_case"
                },

                ["<Up>"] = {
                    "<Nop>",
                    desc = "Disable Up"
                },
                ["<Down>"] = {
                    "<Nop>",
                    desc = "Disable Down"
                },
                ["<Left>"] = {
                    "<Nop>",
                    desc = "Disable Left"
                },
                ["<Right>"] = {
                    "<Nop>",
                    desc = "Disable Right"
                }
            }
        }
    }
}
