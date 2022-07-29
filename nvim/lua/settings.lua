local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

g.mapleader = ','
vim.o.scrolloff = 15
cmd'colorscheme onedark'

opt.colorcolumn = '79'
opt.cursorline = true
opt.number = true
opt.splitright = true
opt.splitbelow = true
opt.mouse = 'a'
opt.termguicolors = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

