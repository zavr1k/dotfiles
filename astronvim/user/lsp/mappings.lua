return {
  n = {
    ["<C-k>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
  },
}
