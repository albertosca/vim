-- nvim-dap + nvim-dap-ui. Sem equivalente no Vim atual (só Neovim).
local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- F-keys mantidas (não fazem mal), mas ,d* funciona sem teclado com Fs.
-- <leader>d sozinho já é gitsigns toggle — mesmo padrão já aceito de
-- ,md/,mdp: Vim espera o timeoutlen pra desambiguar, sem conflito real.
-- ,db*/,dba/,dbf/,dbr já são do dadbod — por isso 't' pra breakpoint, não 'b'.
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP continue' })
vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'DAP toggle breakpoint' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP step over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP step into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP step out' })

vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'DAP continue' })
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = 'DAP toggle breakpoint' })
vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'DAP step over' })
vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'DAP step into' })
vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'DAP step out' })

-- Elixir: elixir-ls já traz um debug adapter embutido (instalado via mason,
-- mesmo pacote do LSP) — sem plugin nem download extra.
local elixir_ls_ok, elixir_ls_pkg = pcall(function()
  return require('mason-registry').get_package('elixir-ls')
end)
if elixir_ls_ok and elixir_ls_pkg:is_installed() then
  dap.adapters.mix_task = {
    type = 'executable',
    command = elixir_ls_pkg:get_install_path() .. '/debug_adapter.sh',
    args = {},
  }
  dap.configurations.elixir = {
    {
      type = 'mix_task',
      name = 'mix test',
      task = 'test',
      taskArgs = { '--trace' },
      request = 'launch',
      startApps = true,
      projectDir = '${workspaceFolder}',
      requireFiles = {
        'test/**/test_helper.exs',
        'test/**/*_test.exs',
      },
    },
  }
end

-- Ruby: usa `rdbg` (gem `debug`, bundled desde Ruby 3.1) no PATH do projeto —
-- não vem instalado globalmente; se o projeto usa rbenv/asdf com Ruby >=3.1,
-- rode `gem install debug` nesse Ruby antes de debugar.
require('dap-ruby').setup()

-- JS/TS: vscode-js-debug via mason (js-debug-adapter).
local js_debug_ok, js_debug_pkg = pcall(function()
  return require('mason-registry').get_package('js-debug-adapter')
end)
if js_debug_ok and js_debug_pkg:is_installed() then
  require('dap-vscode-js').setup({
    debugger_path = js_debug_pkg:get_install_path(),
    adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal' },
  })
  for _, language in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
    dap.configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }
  end
end

-- Go: nvim-dap-go autodetecta o `delve` (precisa dele instalado — `go install
-- github.com/go-delve/delve/cmd/dlv@latest`) e já registra adapter+configs.
require('dap-go').setup()

-- Python: debugpy via mason (mesmo padrão do elixir-ls/js-debug-adapter —
-- aponta pro Python isolado que o mason instalou, não o do sistema/venv).
local debugpy_ok, debugpy_pkg = pcall(function()
  return require('mason-registry').get_package('debugpy')
end)
if debugpy_ok and debugpy_pkg:is_installed() then
  require('dap-python').setup(debugpy_pkg:get_install_path() .. '/venv/bin/python')
end
