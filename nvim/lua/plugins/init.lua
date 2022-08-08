local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Сниппет для скачивания packer
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'joshdick/onedark.vim' -- Цветовая схема
  use 'xiyaowong/nvim-transparent' -- Цветовая схема

  -- набор Lua функций, используется как зависимость в большинстве
  -- плагинов, где есть работа с асинхронщиной
  use 'nvim-lua/plenary.nvim'
  use 'neovim/nvim-lspconfig' -- Конфиги для lsp
  -- Установка lsp серверов
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      require('plugins.lsp-installer')
    end
  }
  -- автодополнения
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip' -- автодополнения для сниппетов
  -- Парссер ЯП для подсветки синтаксиса
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins.treesitter')
    end
  }
  -- движок сниппетов
  use {
    'L3MON4D3/LuaSnip',
    after = 'friendly-snippets',
    config = function()
      require('luasnip/loaders/from_vscode').load({
       paths = {'~/.local/share/nvim/site/pack/packer/start/friendly-snippets'}
      })
    end
  }
  use 'rafamadriz/friendly-snippets' -- гтовые сниппеты
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.telescope')
    end
  }
  -- Файловый менеджер
  use { 'kyazdani42/nvim-tree.lua',
    config = function()
        require('plugins.nvim-tree')
    end
  }
  -- Строка с табами
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require("plugins.bufferline")
    end
  }
  -- Icons
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true; })
    end
  }
  -- Информационная строка внизу
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup()
    end
  }
  -- плагин для простого комментирования кода
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- автоматические закрывающиеся скобки
  use {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup()
    end
  }
  use 'tpope/vim-surround' -- Оборачивине в кавычки
  use 'tpope/vim-repeat' -- может повторять оборачивание
  use 'powerman/vim-plugin-ruscmd' -- Русская раскладка
  -- use 'fisadev/vim-isort' -- Сортировка импортов в python
  use 'mitsuhiko/vim-jinja' -- Поддержда jinja2

  if packer_bootstrap then
    require('packer').sync()
  end
  end
)
