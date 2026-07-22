local keymaps = require('vim-ai-autocomplete.keymaps')
local ghost_text = require('vim-ai-autocomplete.ghost_text')

describe("vim-ai-autocomplete.keymaps.tab_handler", function()
  local buf

  before_each(function()
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)
    ghost_text.clear_suggestion()
  end)

  after_each(function()
    ghost_text.clear_suggestion()
    vim.api.nvim_buf_delete(buf, { force = true })
  end)

  it("com sugestao visivel: aceita (retorna '')", function()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 'def foo()' })
    vim.api.nvim_win_set_cursor(0, { 1, 8 })
    ghost_text.show_suggestion({ 'x)' }, 0)
    assert.are.equal('', keymaps.tab_handler())
  end)

  it("sem sugestao visivel e sem mapeamento original: cai pro Tab literal", function()
    -- tab_handler() e usado como rhs de um mapeamento 'expr' baseado em
    -- callback Lua: o retorno e usado DIRETO como as keys tecladas, sem
    -- ser reavaliado como expressao Vimscript (verificado empiricamente
    -- via nvim_feedkeys) -- por isso comparamos o retorno diretamente,
    -- em vez de envolver com nvim_eval() (que da E15 num tab literal).
    assert.are.equal('\t', keymaps.tab_handler())
  end)
end)

describe("vim-ai-autocomplete.keymaps.complete_model_names", function()
  it("filtra pelo prefixo literal (nao regex)", function()
    vim.g.vim_ai_autocomplete_models = {
      { name = 'gemini-flash', family = 'gemini', model_id = 'x', api_key_env = 'VAA_TEST_KEY_A' },
      { name = 'claude-sonnet', family = 'anthropic', model_id = 'y', api_key_env = 'VAA_TEST_KEY_A' },
    }
    vim.fn.setenv('VAA_TEST_KEY_A', 'x')
    local result = keymaps.complete_model_names('gem')
    assert.are.same({ 'gemini-flash' }, result)
    vim.g.vim_ai_autocomplete_models = nil
  end)
end)

describe("vim-ai-autocomplete.keymaps.setup_provider_toggle", function()
  it("com 2+ modelos ativos, registra ,pr e o comando VimAiAutocompleteModel", function()
    keymaps.setup_provider_toggle({ { name = 'a' }, { name = 'b' } })
    local map = vim.fn.maparg('<leader>pr', 'n', false, true)
    assert.is_not_nil(map.callback)
    assert.is_not_nil(vim.fn.exists(':VimAiAutocompleteModel'))
  end)

  it("com so 1 modelo ativo, nao registra ,pr", function()
    vim.keymap.del('n', '<leader>pr', { buffer = false })
    local ok = pcall(vim.keymap.del, 'n', '<leader>pr')
    keymaps.setup_provider_toggle({ { name = 'a' } })
    local map = vim.fn.maparg('<leader>pr', 'n', false, true)
    assert.are.equal('', map.lhs or '')
  end)
end)
