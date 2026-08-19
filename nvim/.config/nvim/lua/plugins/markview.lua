return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- плагин не поддерживает ленивую загрузку
    opts = {
      preview = {
        filetypes = { "markdown", "markdown.mdx", "quarto", "rmd" },
        ignore_buftypes = { "nofile" },

        -- Гибридный режим (сырой markdown в строке под курсором) настроен,
        -- но по умолчанию выключен: enable_hybrid_mode задаёт стартовое
        -- состояние буфера, и без него строка не разворачивается при
        -- движении курсора. Включается вручную по <leader>mh.
        hybrid_modes = { "n" },
        linewise_hybrid_mode = true,
        enable_hybrid_mode = false,
      },
    },
    keys = {
      { "<leader>mh", "<cmd>Markview hybridToggle<cr>", desc = "Markview: сырая строка под курсором" },
      { "<leader>mm", "<cmd>Markview toggle<cr>", desc = "Markview: рендер вкл/выкл" },
    },
  },

  -- markview заменяет render-markdown.nvim из LazyVim-экстры lang.markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "markdown", "markdown_inline", "html", "yaml", "latex" },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "markdown", icon = "" },
      },
    },
  },
}
