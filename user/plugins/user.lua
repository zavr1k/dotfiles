return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  "morhetz/gruvbox",
  "EdenEast/nightfox.nvim",
  "arcticicestudio/nord-vim",
  "edgedb/edgedb-vim",
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup {
        background = "medium",
      }
    end,
  },
  -- "mattn/emmet-vim", -- надо разробрать как нормально установить
  -- {
  --   "Wansmer/langmapper.nvim",
  --   lazy = false,
  --   priority = 1, -- High priority is needed if you will use `autoremap()`
  --   config = function()
  --     require("langmapper").setup {--[[ your config ]]
  --     }
  --   end,
  -- },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}
