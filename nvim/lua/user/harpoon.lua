-- harpoon2: marca 3-4 arquivos "quentes" do projeto e pula entre eles.
-- <leader>h sozinho já é :bprevious (vimrcs/options.vim) — mesmo padrão já
-- aceito de ,md/,mdp: Vim espera o timeoutlen pra desambiguar, sem conflito.
local harpoon = require('harpoon')
harpoon:setup()

vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'harpoon: add file' })
vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = 'harpoon: menu' })
for i = 1, 4 do
  vim.keymap.set('n', '<leader>h' .. i, function() harpoon:list():select(i) end,
    { desc = 'harpoon: go to ' .. i })
end
