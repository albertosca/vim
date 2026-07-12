-- Telescope: pickers de LSP (fzf.vim já cobre files/grep/buffers/history —
-- ver <leader>gf/rg/bl/ht em configs.vim). <leader>f fica livre no Neovim
-- porque a seção CoC que usava esse prefixo (format-selected) só existe
-- no Vim (if !has('nvim') em configs.vim).
require('telescope').setup({})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'LSP document symbols' })
vim.keymap.set('n', '<leader>fw', builtin.lsp_dynamic_workspace_symbols, { desc = 'LSP workspace symbols' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'LSP references' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })
