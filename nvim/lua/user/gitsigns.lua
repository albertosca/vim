-- gitsigns.nvim substitui vim-gitgutter no Neovim (desligado via
-- g:pathogen_disabled). <leader>d mantém o mesmo lugar (toggle de sinais).
require('gitsigns').setup()

-- toggle_signs() não ecoa nada por padrão (diferente do :GitGutterToggle
-- antigo) — sem feedback, parece que não fez nada. Ecoamos o estado.
vim.keymap.set('n', '<leader>d', function()
  local enabled = require('gitsigns').toggle_signs()
  vim.notify('Gitsigns signs: ' .. (enabled and 'ON' or 'OFF'))
end, { silent = true })
