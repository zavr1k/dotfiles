require('nvim-tree').setup({
  view = {
    adaptive_size = true,
  }
})

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('', '<leader><leader>', ':NvimTreeFindFileToggle<CR>', default_opts)
