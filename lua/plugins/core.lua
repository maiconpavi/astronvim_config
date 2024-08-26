return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "                     ██████╗ ██████╗ ██████╗  █████╗  ",
        "                    ██╔════╝██╔═══██╗██╔══██╗██╔══██╗ ",
        "                    ██║     ██║   ██║██║  ██║███████║ ",
        "                    ██║     ██║   ██║██║  ██║██╔══██║ ",
        "                    ╚██████╗╚██████╔╝██████╔╝██║  ██║ ",
        "                     ╚═════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝ ",
        "                                                      ",
        "                    ███████╗ ██████╗ ███████╗ ██████╗ ",
        "                    ██╔════╝██╔═══██╗██╔════╝██╔═══██╗",
        "                    █████╗  ██║   ██║█████╗  ██║   ██║",
        "                    ██╔══╝  ██║   ██║██╔══╝  ██║   ██║",
        "                    ██║     ╚██████╔╝██║     ╚██████╔╝",
        "                    ╚═╝      ╚═════╝ ╚═╝      ╚═════╝ ",
        "",
        '"A program is like a poem, you cannot write a poem without writing it."',
        "    --- Dijkstra",
      }
      opts.section.buttons.val = {}
      return opts
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      if opts.filesystem == nil then opts.filesystem = {} end
      if opts.filesystem.filtered_items == nil then opts.filesystem.filtered_items = {} end
      -- opts.filesystem.filtered_items.hide_dotfiles = false
      opts.filesystem.filtered_items.always_show = { -- remains visible even if other settings would normally hide it
        ".gitignored",
        ".gitignore",
        ".env",
        ".envrc",
      }
      opts.filesystem.follow_current_file = {
        enable = false,
        leave_dirs_open = true,
      }
      opts.filesystem.use_libuv_file_watcher = true
      opts.filesystem.group_empty_dirs = false

      return opts
    end,
  },
}
