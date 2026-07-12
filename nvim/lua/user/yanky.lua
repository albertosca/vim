-- yanky.nvim substitui coc-yank no Neovim (histórico de yank).
require('yanky').setup({})

vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
-- <C-n>/<C-p> ficam de fora de propósito: é o atalho padrão do
-- vim-visual-multi (Find Under, multi-cursor) — carregando depois via Lua,
-- o yanky ia silenciosamente roubar essa tecla.
vim.keymap.set('n', '<leader>yn', '<Plug>(YankyCycleForward)', { desc = 'yank history: next' })
vim.keymap.set('n', '<leader>yp', '<Plug>(YankyCycleBackward)', { desc = 'yank history: prev' })
