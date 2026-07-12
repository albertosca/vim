describe("infra do plenary (minimal_init)", function()
  it("acha plenary.nvim no runtimepath", function()
    assert.is_not_nil(require('plenary'))
  end)

  it("resolve require('user.X') pro codigo em nvim/lua/user/", function()
    -- flash.lua e o menor arquivo do lua/user/ (sem setup pesado), serve
    -- de canario barato pra confirmar que o path do rtp esta certo.
    assert.has_no.errors(function() require('user.flash') end)
  end)
end)
