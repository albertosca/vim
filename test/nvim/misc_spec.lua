local function has(mode, lhs)
  for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
    if m.lhs == lhs then return true end
  end
  return false
end

describe("user.flash", function()
  require('user.flash')
  it("mapeia 's' (n/x/o) pro flash jump, sem mexer em 'S' (nvim-surround usa)", function()
    assert.is_true(has('n', 's'))
    assert.is_true(has('x', 's'))
    assert.is_true(has('o', 's'))
    assert.is_false(has('n', 'S'))
    assert.is_false(has('x', 'S'))
  end)
end)

describe("user.harpoon", function()
  require('user.harpoon')
  it("mapeia ,ha (add), ,hh (menu) e ,h1..,h4 (ir pro slot N)", function()
    assert.is_true(has('n', ',ha'))
    assert.is_true(has('n', ',hh'))
    for i = 1, 4 do
      assert.is_true(has('n', ',h' .. i))
    end
  end)
end)

describe("user.trouble", function()
  require('user.trouble')
  it("mapeia ,tt (diagnostics) e ,tq (quickfix) pros comandos :Trouble certos", function()
    local function rhs(mode, lhs)
      for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
        if m.lhs == lhs then return m.rhs end
      end
      return nil
    end
    assert.are.equal(':Trouble diagnostics toggle<CR>', rhs('n', ',tt'))
    assert.are.equal(':Trouble qflist toggle<CR>', rhs('n', ',tq'))
  end)
end)

describe("user.treesitter", function()
  require('user.treesitter')
  it("registra o autocmd FileType que liga o highlight via treesitter", function()
    local autocmds = vim.api.nvim_get_autocmds({ event = 'FileType' })
    local found = false
    for _, a in ipairs(autocmds) do
      if a.pattern == 'elixir' then found = true end
    end
    assert.is_true(found)
  end)

  it("mapeia af/if/ac/ic (textobjects) em visual e operator-pending", function()
    for _, mode in ipairs({ 'x', 'o' }) do
      for _, lhs in ipairs({ 'af', 'if', 'ac', 'ic' }) do
        local found = false
        for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
          if m.lhs == lhs then found = true end
        end
        assert.is_true(found, mode .. ':' .. lhs .. ' nao encontrado')
      end
    end
  end)
end)
