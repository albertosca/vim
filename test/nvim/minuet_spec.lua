local provider_logic = require('user.minuet_provider')

describe("user.minuet_provider.resolve (logica pura, sem tocar env/vim.notify)", function()
  it("as duas keys presentes: gemini, sem aviso", function()
    local provider, level, message = provider_logic.resolve(true, true)
    assert.are.equal('gemini', provider)
    assert.is_nil(level)
    assert.is_nil(message)
  end)

  it("so gemini presente: gemini, com aviso mencionando a key que falta", function()
    local provider, level, message = provider_logic.resolve(true, false)
    assert.are.equal('gemini', provider)
    assert.are.equal('warn', level)
    assert.is_not_nil(string.find(message, 'gemini'))
  end)

  it("so claude presente: claude, com aviso mencionando a key que falta", function()
    local provider, level, message = provider_logic.resolve(false, true)
    assert.are.equal('claude', provider)
    assert.are.equal('warn', level)
    assert.is_not_nil(string.find(message, 'claude'))
  end)

  it("nenhuma key presente: erro, sem provider", function()
    local provider, level, message = provider_logic.resolve(false, false)
    assert.is_nil(provider)
    assert.are.equal('error', level)
    assert.is_not_nil(string.find(message, 'GEMINI_API_KEY'))
    assert.is_not_nil(string.find(message, 'ANTHROPIC_API_KEY'))
  end)
end)

describe("user.minuet setup real (usa o ambiente de verdade desta maquina)", function()
  it("registra ,pt sempre", function()
    require('user.minuet')
    local map = vim.fn.maparg(',pt', 'n', false, true)
    assert.is_not_nil(map.callback)
  end)

  it("so registra ,pv se as duas API keys existirem no ambiente real", function()
    require('user.minuet')
    local has_gemini = os.getenv('GEMINI_API_KEY') ~= nil and os.getenv('GEMINI_API_KEY') ~= ''
    local has_claude = os.getenv('ANTHROPIC_API_KEY') ~= nil and os.getenv('ANTHROPIC_API_KEY') ~= ''
    local map = vim.fn.maparg(',pv', 'n', false, true)
    if has_gemini and has_claude then
      assert.is_not_nil(map.callback)
    else
      assert.are.equal('', map.lhs or '')
    end
  end)
end)
