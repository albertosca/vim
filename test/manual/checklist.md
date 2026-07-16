# Checklist de Testes Manuais

Casos que requerem ambiente completo (LSP ativo, tmux, projeto real, banco de dados).
Executar após cada release ou alteração estrutural na configuração.

**Como usar:** marque cada checkbox após verificar manualmente. Registre a data
na seção "Histórico de execuções" ao final.

---

## Pré-requisitos por grupo

| Grupo | Requisitos |
|-------|-----------|
| Alternância de arquivos (`:A`) | Projetos com estrutura completa (Elixir + Phoenix ou Rails) |
| vim-test | Sessão tmux ativa com painel aberto |
| fzf | Vim em modo interativo (não headless) |
| Elixir workflow | Elixir instalado + tmux + projeto Mix |
| Git workflow | Repositório git com histórico |
| Banco de dados | PostgreSQL ou MySQL rodando localmente |
| Sessões | Vim em modo interativo |
| Vimux | Sessão tmux com painel |
| CoC / LSP | ElixirLS, Solargraph ou coc-tsserver inicializados |
| Undotree | undodir configurado em `~/.vim_runtime/temp_dirs/undodir/` |

---

## Alternância de arquivos (`:A` — vim-projectionist / vim-rails)

- [ ] **E2E-017** — `:A` em `lib/foo.ex` abre `test/foo_test.exs`
- [ ] **E2E-018** — `:A` em `test/foo_test.exs` abre `lib/foo.ex`
- [ ] **E2E-019** — `:A` em controller Phoenix abre o controller test correspondente
- [ ] **E2E-020** — `:A` em `app/models/user.rb` abre `spec/models/user_spec.rb`
- [ ] **E2E-021** — `:Emodel User` abre `app/models/user.rb` em projeto Rails

## vim-test — execução de testes

- [ ] **E2E-022** — `,tn` roda teste Elixir mais próximo via Vimux no tmux
- [ ] **E2E-023** — `,tf` roda todos os testes do arquivo atual
- [ ] **E2E-024** — `,ts` roda a suíte completa (`mix test`)
- [ ] **E2E-025** — `,tl` repete o último teste sem renavegar
- [ ] **E2E-026** — `,tn` em arquivo Ruby roda `bundle exec rspec` com linha correta

## fzf — busca

- [ ] **E2E-027** — `Ctrl+f` abre popup fzf de arquivos do projeto
- [ ] **E2E-028** — `Ctrl+b` abre popup fzf de buffers abertos
- [ ] **E2E-029** — `,gf` lista apenas arquivos rastreados pelo git (`:GFiles`)
- [ ] **E2E-030** — `,rg palavra` encontra ocorrências em todos os arquivos

## Elixir — workflow completo

- [ ] **E2E-031** — Auto-format ao salvar `.ex` executa via `mix format` sem erros
- [ ] **E2E-032** — `,lc` executa `mix credo --strict` no painel tmux
- [ ] **E2E-033** — `,ie` abre IEx com `iex -S mix` no painel tmux
- [ ] **E2E-034** — `,mf` formata manualmente arquivo Elixir
- [ ] **E2E-035** — `,md` mostra diff do mix format sem aplicar

## Git — workflow

- [ ] **E2E-036** — `,gv` abre git log navegável (GV)
- [ ] **E2E-037** — `,gV` abre git log apenas do arquivo atual
- [ ] **E2E-038** — `,gm` mostra popup com commit/autor/data da linha atual
- [ ] **E2E-039** — `,d` liga/desliga diff no gutter (gitgutter toggle)

## Banco de dados — workflow

- [ ] **E2E-040** — `,db` abre o DB UI explorer
- [ ] **E2E-041** — `:DB postgresql://... SELECT 1` executa query e mostra resultado
- [ ] **E2E-042** — `:DB mysql://... SELECT 1` executa query MySQL

## Sessões (vim-obsession)

- [ ] **E2E-043** — `,os` inicia tracking criando `Session.vim` no CWD
- [ ] **E2E-044** — Fechar e reabrir Vim sem args restaura sessão automaticamente
- [ ] **E2E-045** — `,os` segunda vez para o tracking (toggle)

## Vimux — integração tmux

- [ ] **E2E-049** — `,vp` abre prompt para digitar comando no tmux
- [ ] **E2E-050** — `,vl` repete último comando no painel tmux
- [ ] **E2E-051** — `,vx` envia Ctrl+C para o painel tmux

## CoC — LSP (requer servidores ativos)

- [ ] **E2E-052** — `K` sobre função Elixir mostra documentação em popup
- [ ] **E2E-053** — `gd` navega para definição da função
- [ ] **E2E-054** — `[g` navega para diagnóstico anterior no arquivo
- [ ] **E2E-055** — `,a` mostra code actions disponíveis
- [ ] **E2E-056** — Tab completa sugestão do ElixirLS (ex: `Enum.m` → `Enum.map`)
- [ ] **E2E-057** — `,rn` renomeia símbolo em todos os arquivos do projeto

## Undotree

- [ ] **E2E-058** — `,u` abre painel de histórico visual de undo
- [ ] **E2E-059** — Histórico de undo persiste após fechar e reabrir o arquivo

## vim-ai-autocomplete — ghost-text Gemini/Claude (Vim clássico)

**Pré-requisito:** `GEMINI_API_KEY` em `~/.zsh_secrets` (já configurado). `ANTHROPIC_API_KEY` opcional — sem ela, `,ap` não deveria nem aparecer (comportamento esperado, não é bug).

- [ ] **E2E-060** — Abrir um arquivo de código real (`.py`/`.ex`/`.js`), digitar uma linha incompleta (ex: `def soma(a, b):`), parar de digitar por ~1s → sugestão cinza aparece (ghost text, não um menu)
- [ ] **E2E-061** — `Tab` com a sugestão visível → aceita o texto de verdade (deixa de ser cinza), cursor avança pro fim do texto inserido
- [ ] **E2E-062** — Sugestão multi-linha (peça algo que gere 2-3 linhas, ex: início de uma função) → `Tab` insere TODAS as linhas corretamente, com quebra de linha real (não tudo numa linha só)
- [ ] **E2E-063** — Com a sugestão visível, apertar `Esc` → sugestão some sem deixar nenhum caractere/lixo no buffer; `:w` + reabrir o arquivo confirma que nada vazou pro arquivo salvo
- [ ] **E2E-064** — **Sem nenhuma sugestão visível**, `Tab` continua funcionando exatamente como antes (CoC): se o menu de completion do CoC estiver aberto, `Tab` navega pro próximo item; em posição normal, insere tab/aciona completion como sempre
- [ ] **E2E-065** — Digitar rápido sem pausar → NÃO deveria disparar sugestão a cada tecla (debounce funcionando, sem lag perceptível na digitação)
- [ ] **E2E-066** — Se `ANTHROPIC_API_KEY` estiver configurada: `,ap` alterna entre Gemini e Claude (mensagem confirma a troca); pedir uma sugestão depois do toggle deveria vir do provider ativo (diferença de "personalidade" da sugestão é um bom sinal, não uma prova rígida)
- [ ] **E2E-067** — Sem `ANTHROPIC_API_KEY`: `,ap` não faz nada / não está mapeado (esperado — confirma que o toggle é condicional)
- [ ] **E2E-068** — Editar dois arquivos diferentes intercalado (trocar de buffer no meio de esperar uma sugestão) → nenhuma sugestão "vaza" pro buffer errado

## minuet-ai.nvim — ghost-text Gemini/Claude (Neovim)

**Pré-requisito:** mesmas API keys do item acima (`~/.zsh_secrets`, compartilhadas entre os dois editores).

- [ ] **E2E-069** — Mesmo teste do E2E-060, agora no `nvim` — sugestão ghost-text aparece depois da pausa
- [ ] **E2E-070** — `Ctrl+y` aceita a sugestão (multi-linha incluso)
- [ ] **E2E-071** — `Ctrl+e` dispensa a sugestão sem deixar lixo
- [ ] **E2E-072** — `,at` liga/desliga o auto-trigger — com ele desligado, sugestão só aparece se invocada manualmente (ver docs do minuet pro comando manual, se quiser testar esse caminho)
- [ ] **E2E-073** — Se `ANTHROPIC_API_KEY` estiver configurada: `,ap` alterna Gemini/Claude (mensagem `Minuet Provider changed to: ...` confirma)
- [ ] **E2E-074** — Sem `ANTHROPIC_API_KEY`: `,ap` não está mapeado (mesmo comportamento condicional do lado Vim)
- [ ] **E2E-075** — Digitar em um buffer, trocar de janela/buffer no meio da espera → sem sugestão vazando pro lugar errado (mesmo espírito do E2E-068)

---

## Histórico de execuções

| Data | Versão / Commit | Resultado | Observações |
|------|----------------|-----------|-------------|
| — | — | — | Primeira execução pendente |

<!-- Para registrar uma execução, adicione uma linha à tabela acima.
     Exemplo:
     | 2026-04-15 | 3778a25 | 32/36 ✓ | E2E-041/042 pulados (sem DB local) |
-->
