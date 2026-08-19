-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- В markdown диагностика (markdownlint + marksman) выключена по умолчанию:
-- стилевые придирки линтера мешают писать текст.
-- <leader>md — показать/скрыть её в текущем буфере.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("md_no_diagnostics", { clear = true }),
  pattern = { "markdown", "markdown.mdx" },
  callback = function(ev)
    vim.diagnostic.enable(false, { bufnr = ev.buf })

    vim.keymap.set("n", "<leader>md", function()
      local on = vim.diagnostic.is_enabled({ bufnr = ev.buf })
      vim.diagnostic.enable(not on, { bufnr = ev.buf })
      vim.notify("Диагностика: " .. (on and "выкл" or "вкл"), vim.log.levels.INFO)
    end, { buffer = ev.buf, desc = "Диагностика в этом буфере" })
  end,
})
