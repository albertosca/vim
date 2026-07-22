local context = require('vim-ai-autocomplete.context')

describe("vim-ai-autocomplete.context.split_lines_at_cursor", function()
  it("corta a linha atual na coluna do cursor -- nao entra inteira em nenhum lado", function()
    local before, after = context.split_lines_at_cursor({ 'linha -1' }, 'def soma()', 10, { 'linha +1' })
    assert.are.same({ 'linha -1', 'def soma(' }, before)
    assert.are.same({ ')', 'linha +1' }, after)
  end)

  it("col=1: nada antes na linha atual", function()
    local before, after = context.split_lines_at_cursor({}, 'abc', 1, {})
    assert.are.same({ '' }, before)
    assert.are.same({ 'abc' }, after)
  end)
end)

describe("vim-ai-autocomplete.context.build_context", function()
  it("junta as linhas com quebra de linha, sem truncar se cabe no budget", function()
    local ctx = context.build_context({ 'a', 'b' }, { 'c', 'd' }, 1000)
    assert.are.equal('a\nb', ctx.before)
    assert.are.equal('c\nd', ctx.after)
  end)

  it("trunca 75/25 quando excede o budget", function()
    local before_lines = { string.rep('x', 100) }
    local after_lines = { string.rep('y', 100) }
    local ctx = context.build_context(before_lines, after_lines, 40)
    assert.are.equal(30, #ctx.before)
    assert.are.equal(10, #ctx.after)
    assert.are.equal(string.rep('x', 30), ctx.before)
    assert.are.equal(string.rep('y', 10), ctx.after)
  end)
end)
