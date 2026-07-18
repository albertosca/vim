local provider_logic = require('user.minuet_provider')

local has_gemini = os.getenv('GEMINI_API_KEY') ~= nil and os.getenv('GEMINI_API_KEY') ~= ''
local has_claude = os.getenv('ANTHROPIC_API_KEY') ~= nil and os.getenv('ANTHROPIC_API_KEY') ~= ''

local provider, level, message = provider_logic.resolve(has_gemini, has_claude)

if level == 'error' then
  error('nvim/lua/user/minuet.lua: ' .. message)
elseif level == 'warn' then
  vim.notify('nvim/lua/user/minuet.lua: ' .. message, vim.log.levels.WARN)
end

require('minuet').setup({
  provider = provider,
  provider_options = {
    -- gemini-2.0-flash foi desativado pelo Google em 2026-03; gemini-3-flash
    -- (a proxima escolha) NUNCA existiu como modelo estavel (confirmado via
    -- ListModels real do lado Vim, 2026-07-18) -- gemini-3.1-flash-lite e o
    -- tier economico atual que de fato funciona (validado com chamada real).
    gemini = { model = 'gemini-3.1-flash-lite' },
    -- Sonnet (nao Haiku, o default do plugin) -- e o Claude "mais esperto"
    -- que o toggle ,pv deveria entregar. Se o nome do modelo mudar no
    -- futuro, checar https://docs.anthropic.com/en/docs/about-claude/models
    claude = { model = 'claude-sonnet-4-5-20250929' },
  },
  virtualtext = {
    auto_trigger_ft = { '*' },
    keymap = {
      accept = '<C-y>',
      dismiss = '<C-e>',
    },
  },
  throttle = 1000,
  debounce = 600,
})

-- <leader>pt/<leader>pv, nao <leader>at/<leader>ap: <leader>a ja e mapeado
-- (code actions do CoC) -- as chaves antigas compartilhavam prefixo com um
-- mapeamento completo existente, causando disparo do comando errado se o
-- usuario nao digitasse rapido o suficiente (achado real, reportado pelo
-- Alberto -- mesmo problema no lado Vim, plugins/vim-ai-autocomplete).
vim.keymap.set('n', '<leader>pt', require('minuet.virtualtext').action.toggle_auto_trigger,
  { desc = 'minuet: toggle auto-trigger' })

if has_gemini and has_claude then
  vim.keymap.set('n', '<leader>pv', function()
    local current = require('minuet').config.provider
    local next_provider = current == 'gemini' and 'claude' or 'gemini'
    require('minuet').change_provider(next_provider)
  end, { desc = 'minuet: toggle provider gemini/claude' })
end
