-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  n = {
    ["<leader>s"] = { name = " Surround" },
    ["<leader>lv"] = { "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" },
    ["<leader>fT"] = { "<cmd>Find TODO's<cr>", desc = "Open TODOs in Telescope" },
    -- Text Case
    ["ga."] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "TextCase Telescope" },
    ["gaS"] = { function() require("textcase").lsp_rename "to_snake_case" end, desc = "LSP rename to_snake_case" },
    ["gas"] = { function() require("textcase").current_word "to_snake_case" end, desc = "Convert to_snake_case" },
    -- Trouble
    ["<leader>x"] = { name = " Trouble" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble Workspace Toggle" },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble Document Toggle" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble QuickFix Toggle" },
    ["<leader>U"] = { "<cmd>Telescope undo<cr>", desc = "Undo Tree" },
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
    ["<leader>lpt"] = { "<cmd>terminal echo $(pwd)<cr>", desc = "test" },
    -- Buffer
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>bS"] = { ":wa!<cr>", desc = "Save All Buffers" },
    -- Aerial
    ["[S"] = {
      function() require("aerial").prev_up(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Previous [count] Symbol in Tree",
    },
    -- find in files
    ["<leader>fS"] = { function() require("spectre").open() end, desc = "Open Spectre" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  v = {
    -- Text Case
    ["ga."] = { "<cmd>TextCaseOpenTelescope<CR>", desc = "TextCase Telescope" },
    ["gas"] = { function() require("textcase").current_word "to_snake_case" end, desc = "Convert to_snake_case" },
  },
}
