local M = {}

local function on_attach(_, bufnr)
  require("keymaps.lsp").attach(bufnr)
  pcall(function()
    require("lsp_signature").on_attach({ bind = true, handler_opts = { border = "rounded" } }, bufnr)
  end)
end

local function capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").default_capabilities(caps)
end

function M.setup()
  local lspconfig = require("lspconfig")
  local caps = capabilities()

  local servers = {
    perlls = {
      cmd = { "perl", "-MPerl::LanguageServer", "-e", "Perl::LanguageServer::run" },
      filetypes = { "perl" },
      settings = {
        perl = {
          perlcritic = { enabled = true, severity = 5 },
          perltidy = { enabled = true },
        },
      },
    },
    clangd = {
      cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
    },
    phpactor = {},
    ts_ls = {},
    html = {},
    cssls = {},
    jsonls = {},
    yamlls = {},
    bashls = {},
    dockerls = {},
    marksman = {},
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    },
    sourcekit = {
      cmd = { "sourcekit-lsp" },
      filetypes = { "swift" },
    },
    sqlls = {},
  }

  for name, config in pairs(servers) do
    config.on_attach = on_attach
    config.capabilities = caps
    if lspconfig[name] then
      lspconfig[name].setup(config)
    else
      vim.notify("LSP non disponibile in nvim-lspconfig: " .. name, vim.log.levels.WARN)
    end
  end
end

return M
