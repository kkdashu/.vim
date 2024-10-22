local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

local on_attach = require('lsp_on_attach').on_attach

-- languages
local languages = {'pyright', 'gopls', 'rust_analyzer', 'ts_ls', 'lua_ls', 'dartls', 'html', 'marksman', 'protobuf-language-server', 'sqls', 'denols'}

-- setup nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local key = 'protobuf-language-server'

configs[key] = {
    default_config = {
        cmd = { '~/.gvm/pkgsets/go1.22/global/bin/protobuf-language-server' },
        filetypes = { 'proto', 'cpp' },
        root_fir = util.root_pattern('.git'),
        single_file_support = true,
        settings = {
            -- ["additional-proto-dirs"] = [
            --     -- path to additional protobuf directories
            --     -- "vendor",
            --     -- "third_party",
            -- ]
        },
    }
}

for _, lsp in ipairs(languages) do
  local config = {
    on_attach = on_attach,
    capabilities = capabilities
  }

  if lsp == 'lua_ls' then
    config.settings = {
      Lua = {
        runtime = {
          version = "LuaJIT"
        },
        diagnostics = {
          globals = {'vim'}
        }
      }
    }
  elseif lsp == 'gopls' then
    config.settings = {
      gopls = {
        buildFlags = {'-tags=integration'}
      }
    }
  elseif lsp == 'ts_ls' then
    config.root_dir = nvim_lsp.util.root_pattern("package.json")
    config.single_file_support = false
  elseif lsp == 'denols' then
    config.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")
  end
  nvim_lsp[lsp].setup(config)
end
