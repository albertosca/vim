require('user.dap')
local dap = require('dap')

describe("user.dap", function()
  local function keymap_callback(mode, lhs)
    for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
      if m.lhs == lhs then return m.callback end
    end
    return nil
  end

  it("mapeia ,dc/,dt/,do/,di/,dO pras funcoes certas do dap (sem depender de F-keys)", function()
    assert.are.equal(dap.continue, keymap_callback('n', ',dc'))
    assert.are.equal(dap.toggle_breakpoint, keymap_callback('n', ',dt'))
    assert.are.equal(dap.step_over, keymap_callback('n', ',do'))
    assert.are.equal(dap.step_into, keymap_callback('n', ',di'))
    assert.are.equal(dap.step_out, keymap_callback('n', ',dO'))
  end)

  it("mantem as F-keys mapeadas pras mesmas funcoes (nao quebra quem tem F-keys)", function()
    assert.are.equal(dap.continue, keymap_callback('n', '<F5>'))
    assert.are.equal(dap.toggle_breakpoint, keymap_callback('n', '<F9>'))
    assert.are.equal(dap.step_over, keymap_callback('n', '<F10>'))
    assert.are.equal(dap.step_into, keymap_callback('n', '<F11>'))
    assert.are.equal(dap.step_out, keymap_callback('n', '<F12>'))
  end)

  it("configura o adapter mix_task do Elixir via elixir-ls (mason), sem plugin/download extra", function()
    -- So roda de verdade se o pacote mason elixir-ls ja estiver instalado
    -- nesta maquina (mesma premissa da suite Vim sobre submodules do Pathogen).
    local ok, pkg = pcall(function() return require('mason-registry').get_package('elixir-ls') end)
    if not (ok and pkg:is_installed()) then
      pending('elixir-ls nao instalado via mason nesta maquina')
      return
    end
    assert.are.equal('executable', dap.adapters.mix_task.type)
    assert.is_true(vim.endswith(dap.adapters.mix_task.command, 'debug_adapter.sh'))
    assert.are.equal('mix test', dap.configurations.elixir[1].name)
  end)

  it("configura pwa-node/pwa-chrome pro JS/TS via js-debug-adapter (mason)", function()
    local ok, pkg = pcall(function() return require('mason-registry').get_package('js-debug-adapter') end)
    if not (ok and pkg:is_installed()) then
      pending('js-debug-adapter nao instalado via mason nesta maquina')
      return
    end
    for _, ft in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
      assert.are.equal('pwa-node', dap.configurations[ft][1].type)
    end
  end)
end)
