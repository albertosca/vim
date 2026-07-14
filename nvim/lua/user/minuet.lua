local M = {}

--- Decide qual provider usar e se precisa avisar/travar, sem tocar em
--- os.getenv/vim.notify/error diretamente -- pura e testavel isolada
--- (mesmo padrao de StartScreenLines/StartScreen no lado Vim,
--- ver configs.vim).
--- @param has_gemini boolean
--- @param has_claude boolean
--- @return string|nil provider, string|nil level ('warn'|'error'|nil), string|nil message
function M._resolve_provider(has_gemini, has_claude)
  if not has_gemini and not has_claude then
    return nil, 'error', 'nenhuma API key encontrada (GEMINI_API_KEY nem ANTHROPIC_API_KEY) -- configure pelo menos uma em ~/.zsh_secrets'
  end

  if has_gemini and has_claude then
    return 'gemini', nil, nil
  end

  local provider = has_gemini and 'gemini' or 'claude'
  local message = string.format(
    'só %s disponível (falta a outra API key) -- toggle ,ap desabilitado',
    provider
  )
  return provider, 'warn', message
end

local has_gemini = os.getenv('GEMINI_API_KEY') ~= nil and os.getenv('GEMINI_API_KEY') ~= ''
local has_claude = os.getenv('ANTHROPIC_API_KEY') ~= nil and os.getenv('ANTHROPIC_API_KEY') ~= ''

local provider, level, message = M._resolve_provider(has_gemini, has_claude)

if level == 'error' then
  error('nvim/lua/user/minuet.lua: ' .. message)
elseif level == 'warn' then
  vim.notify('nvim/lua/user/minuet.lua: ' .. message, vim.log.levels.WARN)
end

require('minuet').setup({
  provider = provider,
  provider_options = {
    gemini = { model = 'gemini-2.0-flash' },
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

return M
