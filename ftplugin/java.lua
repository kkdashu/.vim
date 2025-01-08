local on_attach = require('lsp_on_attach').on_attach

local path_to_jdtls = '/opt/homebrew/Cellar/jdtls/1.42.0'
local lombok_path = '/Users/kkdashu/Develop/share/lombok/lombok.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local home_dir = os.getenv('HOME')
local workspace_dir = home_dir .. '/.workspace/' .. project_name

local config = {
    cmd = {

      -- 💀
      -- 'java', -- or '/path/to/java17_or_newer/bin/java'
              -- depends on if `java` is in your $PATH env variable and if it points to the right version.
      '/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home/bin/java',

      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '-javaagent:' .. lombok_path,
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

      -- 💀
      '-jar', path_to_jdtls .. '/libexec/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
           -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
           -- Must point to the                                                     Change this to
           -- eclipse.jdt.ls installation                                           the actual version


      -- 💀
      '-configuration', path_to_jdtls .. '/libexec/config_mac',
                      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                      -- Must point to the                      Change to one of `linux`, `win` or `mac`
                      -- eclipse.jdt.ls installation            Depending on your system.


      -- 💀
      -- See `data directory configuration` section in the README
      '-data', workspace_dir
    },
    --cmd = {'/opt/homebrew/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
config.on_attach = on_attach
require('jdtls').start_or_attach(config)
