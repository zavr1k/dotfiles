vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Packer сам себя

    -----------------------------------------------------------
    -- LSP и автодополнялка
    -----------------------------------------------------------
    -- Collection of configurations for built-in LSP client
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    -- Автодополнялки
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    -- Snippets plugin
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    --
    use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, navigate code

    -----------------------------------------------------------
    -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
    -----------------------------------------------------------
    use 'joshdick/onedark.vim' -- Цветовая схема
    -- Информационная строка внизу
    use { 'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
        require('lualine').setup()
        end,
    }
    -- Табы вверху
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
        config = function()
        require("bufferline").setup{}
        end, 
    } 

    -----------------------------------------------------------
    -- НАВИГАЦИЯ
    -----------------------------------------------------------
    -- Файловый менеджер
    use { 'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() 
            require'nvim-tree'.setup {} 
        end, 
    }    
    -- Нечеткий поиск во всплывающем окне telescope
    use { 'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function() require'telescope'.setup {} 
        end,
    }    
    
    -----------------------------------------------------------
    -- РАЗНЫЕ
    -----------------------------------------------------------
    use 'tpope/vim-surround' -- Оборачивание в кавычки, скобки и тд...
    use 'tpope/vim-repeat' -- Может повторять через . vimsurround
    use { 'numToStr/Comment.nvim',
        config = function() require('Comment').setup() 
        end
    } -- Комментирует по gc
    use 'powerman/vim-plugin-ruscmd' -- Русская раскладка

    -----------------------------------------------------------
    -- PYTHON
    -----------------------------------------------------------
    --- Шапка с импортами приводим в порядок
    -- use 'fisadev/vim-isort'
    -- Поддержка темплейтом jinja2
    -- use 'mitsuhiko/vim-jinja'

end)
