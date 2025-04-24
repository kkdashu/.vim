
vim.diagnostic.config({
  virtual_text = true, -- 显示虚拟文本错误提示
  signs = true,        -- 显示标记符号
  update_in_insert = true, -- 在插入模式下更新诊断
})

-- require("colorizer").setup({
--   user_default_options = {
--     css_fn = true,
--     tailwind = true,
--     rgb_fn = true,
--     hsl_fn = true,
--   }
-- })
vim.opt.termguicolors = true

-- require('ccc').setup({
--   highlighter = {
--     auto_enable = true,
--     lsp = true,
--   }
-- })
