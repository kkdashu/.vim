local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- 不忽略搜索文件
table.insert(vimgrep_arguments, "--no-ignore")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/{build,node_modules}/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--no-ignore", "--glob", "!**/{build,node_modules}/*"},
		},
	},
})
