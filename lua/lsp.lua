local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

local on_attach = require('lsp_on_attach').on_attach

-- languages
local languages = {'pyright', 'gopls', 'rust_analyzer', 'ts_ls', 'lua_ls', 'dartls', 'html', 'marksman', 'protobuf-language-server', 'sqls', 'denols', 'volar', 'tailwindcss', 'html', 'cssls'}

-- html、cssls
-- npm i -g vscode-langservers-extracted

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

-- java 配置在 ffplugin/java.lua 下
for _, lsp in ipairs(languages) do
  local config = {
    on_attach = on_attach,
    capabilities = capabilities
  }

  if lsp == "pyright" then
    local function get_python_path()
        -- local python_path = vim.fn.trim(vim.fn.system("which python"))
        local python_path = vim.fn.systemlist("uv venv python")[1] or "python3.13"
        print('python_path', python_path)
        return python_path
    end
    config.settings = {
      python = {
        analysis = {
        }
      }
    }

  elseif lsp == 'lua_ls' then
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
  elseif lsp == 'rust_analyzer' then
    config.settings = {
     ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
  elseif lsp == 'gopls' then
    config.settings = {
      gopls = {
        buildFlags = {'-tags=integration'}
      }
    }
  elseif lsp == 'ts_ls' then
    -- 找到 vue-language-server 可执行文件
    local vue_ls_bin = vim.fn.exepath("vue-language-server")

    -- 如果找不到，就返回 nil
    local vue_plugin_location = nil
    if vue_ls_bin ~= "" then
      -- vue-language-server 通常在 .../node_modules/.bin/vue-language-server
      -- 所以取上两级目录，拼接到 @vue/language-server
      local root = vim.fn.fnamemodify(vue_ls_bin, ":h:h")
      vue_plugin_location = root .. "/lib/node_modules/@vue/language-server"
    end
    print('location', vue_plugin_location)
    config.init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          -- location = "/Users/kkdashu/.nvm/versions/node/v22.12.0/lib/node_modules/@vue/language-server",
          location = vue_plugin_location,
          languages = {"vue"},
        }
      }
    }
    config.filetypes = { 'vue', 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' }
    config.root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")
    config.single_file_support = false
  elseif lsp == 'tailwindcss' then
    config.settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cx\\(((?:[^()]|\\([^()]*\\))*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }
          }
        }
      }
    }
  elseif lsp == 'volar' then
    config.init_options = {
      vue = {
        hybridMode = true,
      }
    }
    config.settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = {
            enabled = true,
          },
          functionLikeReturnTypes = {
            enabled = true,
          },
          propertyDeclarationTypes = {
            enabled = true,
          },
          parameterTypes = {
            enabled = true,
            suppressWhenArgumentMatchesName = true,
          },
          variableTypes = {
            enabled = true,
          },
        },
      },
    }
  elseif lsp == 'denols' then
    config.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")
  end
  nvim_lsp[lsp].setup(config)
end
