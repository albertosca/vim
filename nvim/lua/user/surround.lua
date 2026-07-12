-- nvim-surround substitui vim-surround no Neovim (desligado via
-- g:pathogen_disabled). Mantém os mesmos atalhos por padrão (ys/cs/ds/S),
-- então o `vmap Si S(i_<esc>f)` de vimrcs/plugins.vim continua funcionando
-- (resolve o `S` embutido em tempo de execução, não de definição).
require('nvim-surround').setup({})
