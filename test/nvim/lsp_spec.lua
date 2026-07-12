require('user.lsp')

describe("user.lsp", function()
  it("registra capabilities do blink.cmp no config global '*'", function()
    local cfg = vim.lsp.config['*']
    assert.is_not_nil(cfg.capabilities)
  end)

  it("liga inlay hints do gopls", function()
    local cfg = vim.lsp.config['gopls']
    assert.is_true(cfg.settings.gopls.hints.assignVariableTypes)
    assert.is_true(cfg.settings.gopls.hints.parameterNames)
  end)

  it("nao habilita ts_ls (typescript-tools.nvim assume, evita anexar os dois juntos)", function()
    -- vim.lsp._enabled_configs e API interna (prefixo _) -- unico jeito de
    -- introspectar isso sem subir um client LSP de verdade. Se quebrar em
    -- upgrade futuro do Neovim, e o primeiro lugar a checar.
    assert.is_nil(vim.lsp._enabled_configs['ts_ls'])
  end)

  it("ruff desliga hoverProvider no on_attach pra nao duplicar o hover do pyright", function()
    local cfg = vim.lsp.config['ruff']
    local fake_client = { server_capabilities = { hoverProvider = true } }
    cfg.on_attach(fake_client)
    assert.is_false(fake_client.server_capabilities.hoverProvider)
  end)

  it("registra o autocmd LspAttach", function()
    local autocmds = vim.api.nvim_get_autocmds({ event = "LspAttach" })
    assert.is_true(#autocmds > 0)
  end)

  it("LspAttach mapeia gd/gi/K/,rn/,ca no buffer, sem mapear gr (colide com tabprev)", function()
    local autocmds = vim.api.nvim_get_autocmds({ event = "LspAttach" })
    local bufnr = vim.api.nvim_create_buf(false, true)
    autocmds[1].callback({ buf = bufnr, data = { client_id = 999999 } })

    local function has_map(lhs)
      for _, m in ipairs(vim.api.nvim_buf_get_keymap(bufnr, 'n')) do
        if m.lhs == lhs then return true end
      end
      return false
    end

    assert.is_true(has_map('gd'))
    assert.is_true(has_map('gi'))
    assert.is_true(has_map('K'))
    assert.is_true(has_map(',rn'))
    assert.is_true(has_map(',ca'))
    assert.is_false(has_map('gr'))
  end)
end)
