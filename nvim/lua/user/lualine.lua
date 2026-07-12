-- lualine.nvim substitui lightline.vim no Neovim (desligado via
-- g:pathogen_disabled). Mesma info essencial: modo, git branch, arquivo,
-- diagnostics (LSP nativo), posição.
require('lualine').setup({
  options = { theme = 'gruvbox' },
  sections = {
    lualine_c = { { 'filename' } },
    lualine_x = { 'diagnostics', 'filetype' },
  },
})
