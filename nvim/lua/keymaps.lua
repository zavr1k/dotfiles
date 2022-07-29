local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

vim.keymap.set('n', '<leader>df', vim.diagnostic.goto_next, {buffer = 0})

map('', '<leader><leader>', ':NvimTreeFindFileToggle<CR>', default_opts)

 -- Переключение буфферов
map('n', '<leader>q', ':bdelete!<CR>', default_opts) -- Закрыть буффер
map('n', '<Space>', ':nohl<CR>', default_opts) -- Убарть подсветку поиска
map('', '<leader>y', '"+y', default_opts) -- Копирование в системный буффер
map('', '<leader>p', '"+p', default_opts) -- Вставка из системного буффера
map('', '<C-l>', '<C-w>j', default_opts)
map('', '<C-k>', '<C-w>k', default_opts)
map('', '<C-h>', '<C-w>h', default_opts)
map('', '<C-l>', '<C-w>l', default_opts)
