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
    -- gemini-2.0-flash foi desativado pelo Google em 2026-03 -- gemini-3-flash
    -- e o modelo atual recomendado pro tier gratuito (1500 req/dia).
    gemini = { model = 'gemini-3-flash' },
    -- Sonnet (nao Haiku, o default do plugin) -- e o Claude "mais esperto"
    -- que o toggle ,ap deveria entregar. Se o nome do modelo mudar no
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

vim.keymap.set('n', '<leader>at', require('minuet.virtualtext').action.toggle_auto_trigger,
  { desc = 'minuet: toggle auto-trigger' })

if has_gemini and has_claude then
  vim.keymap.set('n', '<leader>ap', function()
    local current = require('minuet').config.provider
    local next_provider = current == 'gemini' and 'claude' or 'gemini'
    require('minuet').change_provider(next_provider)
  end, { desc = 'minuet: toggle provider gemini/claude' })
end
