local on_attach = require('lsp_on_attach').on_attach

local config = {
    cmd = {'/opt/homebrew/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
config.on_attach = on_attach
require('jdtls').start_or_attach(config)
