require('bufferline').setup{
  options = {
    offsets = {{filetype = 'NvimTree', text = '', padding = 1}},
    modified_icon = '*',
    tab_size = 0,
    color_icons = false,
  }
}

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', 'L', '<cmd>BufferLineCycleNext<CR>', opts)
map('n', 'H', '<cmd>BufferLineCyclePrev<CR>', opts)
