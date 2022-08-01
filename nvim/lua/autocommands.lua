local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = vim.opt
local opt_local = vim.opt_local

-- Отключает автокомментирование новой строки через о О
autocmd({'BufEnter'}, {
  pattern = '*',
  callback = function()
    opt.fo:remove('c')
    opt.fo:remove('r')
    opt.fo:remove('o')
  end
})

-- Подсветка скопированных строк
local YankHighlightGrp = augroup('YankHighlightGrp', {})
autocmd('TextYankPost', {
	group = YankHighlightGrp,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

-- 2 spaces for selected filetypes
autocmd({'FileType'}, {
  pattern = 'xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja',
  callback = function()
    opt_local.shiftwidth = 2
    opt_local.tabstop = 2
  end
})

--- remove all trailing whitespace on save
-- local TrimWhiteSpaceGrp = augroup('TrimWhiteSpaceGrp', {})
-- autocmd('BufWritePre', {
-- 	group = TrimWhiteSpaceGrp,
--   pattern = '*',
--   command = '%s/\\s\\+$//e',
-- })

-- sql: format sql files on save via pgFormatter
-- autocmd({'BufWritePre'}, {
--   pattern = '*.sql',
--   command = ':%!pg_format'
-- })
