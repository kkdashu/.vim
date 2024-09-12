vim.api.nvim_create_user_command('Fmt', function()
  vim.lsp.buf.format()
end, {})
