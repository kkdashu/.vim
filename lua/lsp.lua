local nvim_lsp = require('lspconfig')

local on_attach = require('lsp_on_attach').on_attach

-- languages
local languages = {'pyright', 'gopls', 'rust_analyzer', 'ts_ls', 'lua_ls', 'dartls', 'html', 'marksman', 'bufls'}

-- setup nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
  end
  nvim_lsp[lsp].setup(config)
end
