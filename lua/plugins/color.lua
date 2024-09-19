local onedark = require('onedark')
onedark.load()
onedark.setup {
  style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false,  -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- toggle theme style ---
  toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
      comments = 'italic',
      keywords = 'none',
      functions = 'none',
      strings = 'none',
      variables = 'none'
  },

  -- Lualine options --
  lualine = {
      transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {
    -- ["@comment"] = {fg = '#677083'}
    ["@comment"] = {fg = '#5C6370'}
  },

  -- Plugins Config --
  diagnostics = {
      darker = true, -- darker colors for diagnostic
      undercurl = true,   -- use undercurl instead of underline for diagnostics
      background = true,    -- use background color for virtual text
  },

}


-- vim config
-- " colorscheme
-- " 注释颜色太暗了，调亮一点
-- " let g:onedark_color_overrides = {
-- " \ "comment_grey": {"gui": "#5C6370", "cterm": "246", "cterm16": "11" },
-- " \}
-- " let g:onedark_termcolors=256
-- " Enable syntax highlighting
-- " colorscheme onedark
-- " colorscheme xcodedark
