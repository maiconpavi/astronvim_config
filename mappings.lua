-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["ga."] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "TextCase Telescope" },
    ["gaS"] = { function() require("textcase").lsp_rename "to_snake_case" end, desc = "LSP rename to_snake_case" },
    ["gas"] = { function() require("textcase").current_word "to_snake_case" end, desc = "Convert to_snake_case" },
    -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    ["<leader>u"] = { "<cmd>Telescope undo<cr>", desc = "Undo" },
    -- Cargo commands
    ["<leader>lg"] = { name = " Cargo" },
    ["<leader>lgf"] = {
      "<cmd>! cargo fix --allow-dirty --allow-staged --allow-no-vcs --workspace<cr>",
      desc = "Cargo Fix",
    },
    ["<leader>lgt"] = { "<cmd>terminal cargo test<cr>", desc = "Cargo Test" },
    ["<leader>lgT"] = { "<cmd>terminal cargo test --workspace<cr>", desc = "Cargo Test Workspace" },
    -- Python commands
    ["<leader>lp"] = { name = " Python" },
    ["<leader>lpr"] = { "<cmd>terminal python3 %<cr>", desc = "Run Python File" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    ["ga."] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "TextCase Telescope" },
    ["gas"] = { function() require("textcase").current_word "to_snake_case" end, desc = "Convert to_snake_case" },
  },
}
