local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

local on_attach = require('lsp_on_attach').on_attach

-- languages
local languages = {'pyright', 'gopls', 'rust_analyzer', 'ts_ls', 'lua_ls', 'dartls', 'html', 'marksman', 'protobuf-language-server', 'sqls', 'denols', 'volar', 'tailwindcss'}

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
        local python_path = vim.fn.trim(vim.fn.system("which python"))
        return python_path
    end

    local function remove_last_part(str)
        local last_dot_index = string.find(str, "%.[^%.]*$")
        if last_dot_index then
            return string.sub(str, 1, last_dot_index - 1)
        end
        return str  -- 如果没有点，返回原字符串
    end

    local function get_python_extra_path()
        -- 获取当前 Python 版本 3.11.11 -> 3.11
        local python_version = remove_last_part(vim.fn.trim(vim.fn.system("pyenv version-name")))
        if python_version and python_version ~= "" then
            local path = vim.fn.expand(".venv/lib/python" .. python_version .. "/site-packages")
            return path
        else
            return nil
        end
    end
    config.settings = {
      python = {
        pythonPath = get_python_path(),
        analysis = {
          extraPaths = { get_python_extra_path() },
          -- extraPaths = { ".venv/lib/python3.12/site-packages" },
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
    config.init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "/usr/local/lib/node_modules/@vue/language-server",
          languages = {"vue"},
        }
      }
    }
    config.filetypes = { 'vue', 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' }
    config.root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")
    config.single_file_support = false
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
