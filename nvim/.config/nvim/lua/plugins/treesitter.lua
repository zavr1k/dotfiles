-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-i>",
        node_incremental = "<C-i>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  -- opts = {
  --   ensure_installed = {
  --     "lua",
  --     "vim",
  --     -- add more arguments for adding more treesitter parsers
  --   },
  -- },
}
