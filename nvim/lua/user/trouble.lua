-- trouble.nvim: lista navegável de diagnostics/quickfix/loclist num split.
require('trouble').setup({})

vim.keymap.set('n', '<leader>tt', ':Trouble diagnostics toggle<CR>', { silent = true, desc = 'trouble: diagnostics' })
vim.keymap.set('n', '<leader>tq', ':Trouble qflist toggle<CR>', { silent = true, desc = 'trouble: quickfix' })
