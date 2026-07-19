-- copilot.lua + CopilotChat.nvim substituem copilot-chat.vim/vim-claude-code
-- no Neovim (desligados na Fase 1 por incompatibilidade). Precisa de login:
-- rode `:Copilot auth` uma vez (abre browser + código de dispositivo) —
-- login interativo, não dá pra automatizar.

-- Desativado por padrao (pedido do Alberto, 2026-07-18) -- o copilot.vim
-- irmao do lado Vim estava lancando erro em toda abertura (E723/E10 no
-- client startup, achado real durante teste manual). Simetria entre os
-- dois lados: desliga aqui tambem, mesmo sem termos reproduzido o erro
-- especifico no lado Neovim. Pra reativar: mudar pra `true` e reiniciar.
local copilot_enabled = false

if copilot_enabled then
  require('copilot').setup({
    suggestion = { enabled = false }, -- sugestão inline fica pro CoC (Vim) / gosto pessoal
    panel = { enabled = false },
  })

  require('CopilotChat').setup({})

  -- Mesmos atalhos que copilot-chat.vim usava no Vim (configs.vim:561/562).
  vim.keymap.set('n', '<leader>pc', ':CopilotChatOpen<CR>', { silent = true })
  vim.keymap.set('x', '<leader>cq', ':CopilotChat<Space>', {})
end
