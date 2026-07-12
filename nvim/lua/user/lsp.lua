-- LSP nativo (mason + nvim-lspconfig + blink.cmp), substituindo o CoC só no
-- lado Neovim. Vim continua com coc.nvim + coc-settings.json sem alteração.
-- Mapeamento coc-extension -> servidor mason: ver tabela em
-- ~/.claude/plans/squishy-crafting-clover.md.

require('mason').setup()

-- automatic_enable: assim que um pacote da lista abaixo termina de instalar,
-- mason-lspconfig chama vim.lsp.enable() com o nome de servidor lspconfig
-- correto (a instalação em si é feita pelo mason-tool-installer, não aqui —
-- ensure_installed neste plugin não dispara download na versão atual).
require('mason-lspconfig').setup({
  automatic_enable = true,
})

-- Nomes de PACOTE mason (diferem dos nomes de servidor lspconfig usados acima
-- pro on_attach/keymaps — ex.: 'elixir-ls' aqui vira o servidor 'elixirls').
require('mason-tool-installer').setup({
  ensure_installed = {
    -- typescript-language-server FORA de propósito: substituído por
    -- typescript-tools.nvim (fala direto com o tsserver, não usa mason).
    'elixir-ls', 'gopls', 'pyright', 'ruff', 'ruby-lsp',
    'html-lsp', 'css-lsp', 'json-lsp', 'yaml-language-server', 'lemminx',
    'bash-language-server', 'sqls', 'dockerfile-language-server',
    'docker-compose-language-service', 'tailwindcss-language-server',
    'emmet-language-server', 'eslint-lsp',
    'prettier', 'stylelint', 'markdownlint-cli2',
    'js-debug-adapter', -- DAP: JS/TS (Fase 5, ver user/dap.lua)
    'debugpy', -- DAP: Python (ver user/dap.lua)
  },
})

-- ts_ls explicitamente desligado: se já estava instalado de antes da troca
-- pro typescript-tools.nvim, não deixa os dois anexarem juntos no mesmo buffer.
vim.lsp.enable('ts_ls', false)

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- Inlay hints: pyright (OSS) não anuncia essa capability — só o Pylance
-- (fechado, só-VSCode) tem inlay hints ricos pra Python. Go e TS/JS suportam
-- de verdade, mas cada um exige settings próprias pra ligar.
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})

-- ruff complementa o pyright (lint/fix/organize-imports rápido, mesmo
-- toolchain do padrão de qualidade Python de sempre) — hover desligado pra
-- não duplicar o hover do pyright no mesmo buffer.
vim.lsp.config('ruff', {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
})

require('conform').setup({
  formatters_by_ft = {
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
  },
})

require('lint').linters_by_ft = {
  css = { 'stylelint' },
  scss = { 'stylelint' },
  markdown = { 'markdownlint-cli2' },
}
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function() require('lint').try_lint() end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    -- 'gr' fica de fora de propósito: colide com o `gr = :tabprev` de sempre
    -- (configs.vim:62, compartilhado com o Vim) — Neovim >=0.11 já mapeia
    -- 'grr' nativamente pra references, sem precisar de config nenhuma aqui.
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>fo', function()
      require('conform').format({ bufnr = args.buf })
    end, opts)

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.diagnostic.config({ virtual_text = true, severity_sort = true })
