local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = function() 
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = 0})
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', 'gD', vim.lsp.buf.definition, {buffer = 0})
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer = 0})
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {buffer = 0})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer = 0})
    end,
  }
  server:setup(opts)
end)
