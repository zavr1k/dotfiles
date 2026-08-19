-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Проверка орфографии: LazyVim включает spell для markdown/text/gitcommit,
-- но с одним английским словарём весь русский текст помечается как ошибка.
vim.opt.spelllang = { "en", "ru" }
