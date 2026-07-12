-- render-markdown.nvim: tabelas, headers, checkboxes renderizados direto no
-- buffer (via treesitter) — sem sair do Neovim pra ver como fica.
require('render-markdown').setup({
  pipe_table = {
    -- 'padded' (default) estica TODA célula da coluna até a largura da
    -- maior célula — uma linha de tabela com texto grande deixa a tabela
    -- inteira larga e feia. 'raw' só troca os '|', sem inflar largura.
    cell = 'raw',
  },
})

-- ,mr — liga/desliga a renderização (é passiva, entra ligada sozinha ao
-- abrir um .md; sem atalho fica fácil esquecer como desfazer).
vim.keymap.set('n', '<leader>mr', ':RenderMarkdown toggle<CR>', { silent = true })
