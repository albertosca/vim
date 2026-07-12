-- flash.nvim: motions f/F/t/T com labels + salto pra qualquer palavra na tela.
-- Só 's' (não 'S' — o binding sugerido do flash pra treesitter-jump colidiria
-- com o 'S' visual do nvim-surround, que é mais usado). Perde 's' como
-- "substituir char" (Vim nativo) — `cl` faz a mesma coisa.
require('flash').setup({})

vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  require('flash').jump()
end, { desc = 'Flash jump' })
