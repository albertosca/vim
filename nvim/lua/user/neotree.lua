-- neo-tree.nvim substitui nerdtree + vim-nerdtree-syntax-highlight no Neovim
-- (desligados via g:pathogen_disabled). Mesmos atalhos de sempre — o mapping
-- aqui sobrescreve o antigo (:h ~/.vimrc carrega antes dos require() Lua).
require('neo-tree').setup({
  window = { position = 'left', width = 35 },
  filesystem = { filtered_items = { hide_dotfiles = false } },
})

vim.keymap.set('n', '<leader>nn', ':Neotree toggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>nf', ':Neotree reveal<CR>', { silent = true })
