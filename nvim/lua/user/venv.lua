-- venv-selector.nvim: troca de virtualenv Python sem reiniciar o Neovim —
-- reconfigura o LSP (pyright/ruff) e a env do terminal integrado sozinho.
require('venv-selector').setup()

vim.keymap.set('n', '<leader>pv', ':VenvSelect<CR>', { silent = true, desc = 'select python venv' })
