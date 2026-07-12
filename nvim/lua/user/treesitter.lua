-- nvim-treesitter (branch 'main', API pós-reescrita: sem mais .configs.setup,
-- highlight/indent ligados via vim.treesitter.start() por FileType).
local ts = require('nvim-treesitter')

local parsers = {
  'elixir', 'heex', 'eex', 'erlang', 'ruby', 'javascript', 'typescript', 'tsx',
  'python', 'go', 'gomod', 'rust', 'lua', 'vim', 'vimdoc', 'markdown',
  'markdown_inline', 'json', 'yaml', 'html', 'css', 'bash', 'dockerfile', 'sql',
}

ts.install(parsers)

-- filetypes reais que ligam o highlight (nomes de parser divergem de filetype
-- em alguns casos: vimdoc->help, bash->sh, tsx->typescriptreact).
local filetypes = {
  'elixir', 'heex', 'eex', 'erlang', 'ruby', 'javascript', 'javascriptreact',
  'typescript', 'typescriptreact', 'python', 'go', 'gomod', 'rust', 'lua',
  'vim', 'help', 'markdown', 'json', 'yaml', 'html', 'css', 'scss',
  'sh', 'bash', 'dockerfile', 'sql', 'mysql', 'plsql',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    pcall(vim.treesitter.start)
    -- Fold por treesitter (mais preciso que indent) — window-local, só afeta
    -- Neovim; foldlevel=99 já vem do configs.vim compartilhado (tudo aberto).
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})

-- nvim-treesitter-textobjects: af/if (função), ac/ic (classe) em visual/operator-pending.
local select = require('nvim-treesitter-textobjects.select')
local textobjects_map = {
  af = '@function.outer', ['if'] = '@function.inner',
  ac = '@class.outer', ic = '@class.inner',
}
for lhs, query in pairs(textobjects_map) do
  vim.keymap.set({ 'x', 'o' }, lhs, function()
    select.select_textobject(query, 'textobjects')
  end)
end

-- nvim-treesitter-context: fixa a linha da função/classe atual no topo ao rolar.
require('treesitter-context').setup({})
