-- glow.nvim: mesmo `glow` do Vim, mas em janela flutuante larga (sem o
-- split apertado) e num buffer normal (sem pager interativo — rola com
-- j/k/gg/G de verdade). Sobrescreve ,mg só no Neovim; o Vim mantém o :term.
-- glow.nvim spawna o `glow` via jobstart sem terminal de verdade (pipe, não
-- pty) — o glow detecta isso e desliga cor + degrada as bordas da tabela
-- (viram bem sem contraste). CLICOLOR_FORCE força cor mesmo sem tty; o
-- processo filho herda isso do ambiente do Neovim automaticamente.
vim.fn.setenv('CLICOLOR_FORCE', '1')

require('glow').setup({
  width_ratio = 0.9,
  height_ratio = 0.9,
})

vim.keymap.set('n', '<leader>mg', ':Glow<CR>', { silent = true })
