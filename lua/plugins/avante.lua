local avante = require("avante")
require('avante_lib').load()
local config = {
  -- provider = "aihubmix",
  provider = "deepseek",
  providers = {
    aihubmix = {
      -- model = "gemini-2.0-flash-lite"
      model = "gpt-4.1-mini",
    },
    deepseek = {
      __inherited_from = "openai",
      api_key_name = "DEEPSEEK_API_KEY",
      endpoint = "https://api.deepseek.com",
      model = "deepseek-coder",
    },
    qianwen = {
      __inherited_from = "openai",
      api_key_name = "DASHSCOPE_API_KEY",
      endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
      model = "qwen-coder-plus-latest",
    },
  },
  --aihubmix = {
    -- model = "gemini-2.0-flash-lite"
    -- model = "gpt-4.1-mini",
  --},
  chat_history = {
    enabled = true,
    max_history = 50,
    storage_path = vim.fn.stdpath('data') .. '/avante_chat_history.json',
  },
  behaviour = {
    auto_focus_sidebar = true,
    auto_suggestions = false,
    auto_suggestions_respect_ignore = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    jump_result_buffer_on_finish = false,
    support_paste_from_clipboard = false,
    minimize_diff = true,
  },
  history = {
    max_tokens = 4096,
    storage_path = vim.fn.stdpath("state") .. "/avante",
  },
  sidebar = {
    close = { "<C-c>" }
  },
  -- mappings = {
  --   ask = "<leader>sk",
  -- },
  windows = {
    -- input = {
    --   border = "rounded",
    --   width = 60,
    --   height = 10,
    -- },
    -- output = {
    --   border = "rounded",
    --   width = 60,
    --   height = 20,
    -- },
    ask = {
      floating = true,
      border = "rounded",
      start_insert = true
    }
  },
  repo_map = {
    ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules" }, -- ignore files matching these
    negate_patterns = {},                                                       -- negate ignore files matching these.
  },
  --- @class AvanteFileSelectorConfig
  file_selector = {
    --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string | fun(params: avante.file_selector.IParams|nil): nil
    -- provider = multi_file_selector,
    -- Options override for custom providers
    provider_opts = {},
  },
}
avante.setup(config)
