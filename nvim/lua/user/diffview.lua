-- diffview.nvim: tab dedicada pra revisar diff arquivo-por-arquivo (branch,
-- commit, ou staged) antes de commitar.
require('diffview').setup({})

vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { silent = true, desc = 'diffview: open' })
vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { silent = true, desc = 'diffview: close' })
