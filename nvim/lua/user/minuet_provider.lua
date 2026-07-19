local M = {}

--- Decide qual provider usar e se precisa avisar/travar, sem tocar em
--- os.getenv/vim.notify/error diretamente -- pura e testavel isolada
--- (mesmo padrao de StartScreenLines/StartScreen no lado Vim, ver
--- configs.vim). Extraida pra este submodulo proprio (sem nenhum efeito
--- colateral, nem os.getenv) pra minuet_spec.lua conseguir testar essa
--- logica sem disparar o error() de user/minuet.lua numa maquina sem
--- API key nenhuma.
--- @param has_gemini boolean
--- @param has_claude boolean
--- @return string|nil provider, string|nil level ('warn'|'error'|nil), string|nil message
function M.resolve(has_gemini, has_claude)
  if not has_gemini and not has_claude then
    return nil, 'error', 'nenhuma API key encontrada (GEMINI_API_KEY nem ANTHROPIC_API_KEY) -- configure pelo menos uma em ~/.zsh_secrets'
  end

  if has_gemini and has_claude then
    return 'gemini', nil, nil
  end

  local provider = has_gemini and 'gemini' or 'claude'
  local message = string.format(
    'só %s disponível (falta a outra API key) -- toggle ,pr desabilitado',
    provider
  )
  return provider, 'warn', message
end

return M
