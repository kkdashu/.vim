vim.g.augment_workspace_folders = {
  '~/work/leto/leto_client'
}
vim.g.augment_disable_completions = false

vim.api.nvim_set_keymap('n', '<leader>ac', ':Augment chat<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>ac', ':Augment chat<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>an', ':Augment chat-new<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>at', ':Augment chat-toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-y>', '<cmd>call augment#Accept()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<CR>', '<cmd>call augment#Accept("\\n")<cr>', { noremap = true, silent = true })
