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

    local function get_python_extra_path()
        -- 1. 定义获取 Python 版本的 uv 命令
        local uv_python_version_cmd = "uv run python --version"
        -- 2. 执行命令
        -- vim.fn.system() 会返回命令的标准输出
        -- 我们也需要检查 vim.v.shell_error 来确保命令成功执行
        local raw_version_output = vim.fn.trim(vim.fn.system(uv_python_version_cmd))

        -- 3. 检查命令是否成功执行并且有输出
        if vim.v.shell_error == 0 and raw_version_output and raw_version_output ~= "" then
            -- 4. 解析输出以提取完整的 Python 版本号
            --    例如，从 "Python 3.11.7" 中提取 "3.11.7"
            --    或者从 "Python 3.12.0b1" 中提取 "3.12.0b1"
            local full_python_version = string.match(raw_version_output, "Python%s+([%w%.%-]+)")

            if full_python_version and full_python_version ~= "" then
                -- 5. 从完整版本号中提取 "主版本.次版本" (例如 "3.11")
                --    这取代了你原始脚本中 remove_last_part 的功能，如果其目标是 "X.Y.Z" -> "X.Y"
                local python_major_minor = string.match(full_python_version, "^(%d+%.%d+)")

                if python_major_minor and python_major_minor ~= "" then
                    -- 6. 构建 site-packages 路径
                    --    原脚本使用 ".venv/lib/python..." 这种相对路径结构
                    local site_packages_path_str = ".venv/lib/python" .. python_major_minor .. "/site-packages"
                    local expanded_path = vim.fn.expand(site_packages_path_str) -- 解析路径，例如处理 '~'

                    -- (可选) 调试信息
                    -- print("UV Raw Output: " .. raw_version_output)
                    -- print("Extracted Full Version: " .. full_python_version)
                    -- print("Extracted Major.Minor: " .. python_major_minor)
                    -- print("Constructed Path String: " .. site_packages_path_str)
                    -- print("Expanded Path: " .. expanded_path)

                    -- 7. 检查路径是否存在且为目录
                    if vim.fn.isdirectory(expanded_path) == 1 then
                        -- 如果你的原始脚本中的 print(path) 是用于实际输出而非仅调试，可以在此打印 expanded_path
                        -- print(expanded_path)
                        return expanded_path
                    else
                        -- (可选) 通知用户路径未找到
                        -- vim.notify("uv: site-packages 路径未找到或不是一个目录: " .. expanded_path, vim.log.levels.WARN)
                        return nil
                    end
                else
                    -- (可选) 通知用户无法提取 major.minor 版本
                    -- vim.notify("uv: 无法从 '" .. full_python_version .. "' 中提取 major.minor 版本", vim.log.levels.WARN)
                    return nil
                end
            else
                -- (可选) 通知用户无法从 uv 输出中解析 Python 版本
                -- vim.notify("uv: 无法从 uv 输出 '" .. raw_version_output .. "' 中解析 Python 版本", vim.log.levels.WARN)
                return nil
            end
        else
            -- (可选) 通知用户 uv 命令执行失败
            -- local error_msg = string.format("uv: 命令 '%s' 执行失败或无输出. shell_error: %s, output: '%s'",
            --                                 uv_python_version_cmd, vim.v.shell_error, raw_version_output)
            -- vim.notify(error_msg, vim.log.levels.WARN)
            return nil
        end
    end
    config.settings = {
      python = {
        pythonPath = get_python_path(),
        analysis = {
          extraPaths = { get_python_extra_path() },
          -- extraPaths = { ".venv/lib/python3.13/site-packages" },
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
