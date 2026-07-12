-- typescript-tools.nvim substitui ts_ls (desligado em user/lsp.lua) — fala
-- direto com o protocolo nativo do tsserver (igual o VSCode), mais rápido em
-- projetos grandes. Inlay hints (movidos daqui de user/lsp.lua) vão nas
-- settings próprias dele, não em vim.lsp.config.
local inlay_hints = {
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

require('typescript-tools').setup({
  settings = {
    tsserver_file_preferences = inlay_hints,
  },
})
