# Nvim GP

> Cockpit Neovim professionale per Perl, PostgreSQL, CLIPS, backend/security engineering e workflow AI-friendly.

[![License: BSD-3-Clause](https://img.shields.io/badge/license-BSD--3--Clause-2f6f73.svg)](LICENSE)
[![Neovim](https://img.shields.io/badge/Neovim-terminal--native-57a143.svg)](init.lua)
[![Perl First](https://img.shields.io/badge/Perl-first-6b4fbb.svg)](lua/perl/toolchain.lua)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-first-31648c.svg)](lua/database/config.lua)
[![AI Friendly](https://img.shields.io/badge/AI-friendly-8a5cf6.svg)](docs/AI_WORKFLOW.md)
[![CLIPS XS](https://img.shields.io/badge/CLIPS-Perl%20XS-bb4d3e.svg)](docs/CLIPS.md)

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│ NVIM GP                                                                      │
│ Perl discipline · PostgreSQL cockpit · CLIPS expert systems · UNIX workflow   │
│ Locale · leggibile · riproducibile · terminal-native · AI-ready              │
└──────────────────────────────────────────────────────────────────────────────┘
```

Nvim GP non e una config “carina”. E una distribuzione Neovim pensata come workstation tecnica quotidiana: sobria, veloce, leggibile, MacPorts-first su macOS, portabile su Debian e Windows 11, con Perl al centro e workflow backend/security reali.

## Identita

| Asse | Scelta |
| --- | --- |
| Editor | Neovim modulare con `lazy.nvim` |
| Filosofia | UNIX cockpit, non clone VS Code |
| Linguaggio primario | Perl enterprise/security-grade |
| Database primario | PostgreSQL |
| Sistemi esperti | CLIPS con runtime applicativo Perl XS |
| UI | scura, leggibile, tecnica, senza rumore |
| AI | opt-in, locale, context snapshot, niente provider remoto automatico |
| Piattaforme | macOS Apple Silicon, Debian, Windows 11, WSL2 Debian |
| Licenza | BSD 3-Clause |

## Primo Avvio

### macOS Apple Silicon + MacPorts

```zsh
cd /Users/gpicchiarelli/Documents/nvim-gp
./scripts/bootstrap_macports.sh
./scripts/install.sh
nvim
```

### Debian

```bash
cd /Users/gpicchiarelli/Documents/nvim-gp
./scripts/bootstrap_debian.sh
./scripts/install.sh
nvim
```

Su Debian `fd` puo essere esposto come `fdfind`; lo health-check lo gestisce.

### Windows 11

```powershell
cd C:\percorso\nvim-gp
.\scripts\bootstrap_windows.ps1
.\scripts\install_windows.ps1
nvim
```

Per il profilo UNIX completo su Windows: Windows Terminal + WSL2 Debian.

## Superfici IDE

| Dominio | Capacita |
| --- | --- |
| Perl | LSP, critic severity 5, perltidy, prove, Test2, carton, cpanm, POD, NYTProf, perlimports |
| PostgreSQL | dadbod, explorer schema, query runner, helper DBA, saved queries |
| C/C++ | clangd, clang-format, CMake, LLDB |
| PHP | PHPActor, Composer, PHPUnit, php-cs-fixer |
| Web | HTML, CSS, JS, TS, JSON, YAML, Markdown |
| Swift | sourcekit-lsp, swift-format, LLDB |
| CLIPS | `.clp`, syntax, snippets, REPL, facts, agenda, Perl XS smoke/test |
| AI | `:AIContesto`, `.aiignore`, prompt pack, `AGENTS.md`, context budget |
| Sistema | dashboard/statusline con host, OS, CPU/load, RAM, IP, uptime |

## Tastiera

Leader: `SPAZIO`

| Gruppo | Significato |
| --- | --- |
| `SPAZIO f` | file |
| `SPAZIO g` | grep, git, comandi |
| `SPAZIO b` | database |
| `SPAZIO d` | debug |
| `SPAZIO e` | sistemi esperti, CLIPS, Perl XS |
| `SPAZIO t` | test e task |
| `SPAZIO c` | codice, critic, audit |
| `SPAZIO p` | progetto e outline |
| `SPAZIO h` | help, POD, salute |
| `SPAZIO l` | LSP |
| `SPAZIO s` | simboli e sistema |
| `SPAZIO a` | AI locale |
| `SPAZIO r` | refactor, REST, registro |
| `SPAZIO q` | quickfix |
| `SPAZIO w` | workspace |
| `SPAZIO z` | tmux, focus, sessione |

## Comandi Iconici

```vim
:ApriProgetto          " file tree disciplinato
:CercaFile             " fuzzy finder
:CercaTesto            " live grep
:Formato               " format deterministico
:CriticaPerl           " Perl::Critic severity 5
:EseguiTest            " prove sul file corrente
:ApriDatabase          " database cockpit
:Sistema               " pannello macchina
:AIContesto            " snapshot AI pulito
:CLIPSPerlXSCheck      " verifica binding XS CLIPS
:CLIPSPerlXSTest       " prove -lr t per integrazione CLIPS/Perl
```

## Perl First

Perl non e un plugin in questa distribuzione. E il centro operativo:

- `Perl::LanguageServer`
- `Perl::Critic` severity 5
- `Perl::Tidy`
- `prove -lv` e `prove -lr t`
- `Test2::V0`
- `carton`, `cpanm`, `perlimports`
- POD preview/check
- stacktrace quickfix
- NYTProf
- workflow CLIPS XS via Perl

## CLIPS + Perl XS

Il supporto CLIPS considera due livelli:

| Livello | Uso |
| --- | --- |
| Binario `clips` | REPL, check isolato, facts, agenda |
| Modulo Perl XS | runtime applicativo primario |

Comandi principali:

```vim
:CLIPSConsole
:CLIPSCheck
:CLIPSEsegui
:CLIPSAgenda
:CLIPSPerlXSCheck
:CLIPSPerlXSVersione
:CLIPSPerlXSDoc
:CLIPSPerlXSTest
:CLIPSPerlXSScratch
```

Il nome modulo XS predefinito e `CLIPS`. Per cambiarlo:

```lua
vim.g.nvim_gp_clips_xs_module = "Nome::Modulo::XS"
```

oppure:

```zsh
export NVIM_GP_CLIPS_XS_MODULE='Nome::Modulo::XS'
```

Guida completa: [docs/CLIPS.md](/Users/gpicchiarelli/Documents/nvim-gp/docs/CLIPS.md)

## AI-Friendly

Nvim GP e predisposto per agenti AI senza rendere l’editor dipendente da un servizio remoto.

| Comando | Scopo |
| --- | --- |
| `:AIStato` | mostra la policy AI locale |
| `:AIContesto` | genera `.ai/context.md` |
| `:AIPolicy` | apre le regole operative |
| `:AIPromptReview` | prompt review senior |
| `:AIPromptPerformance` | prompt prestazioni |
| `:AIPromptPerl` | prompt Perl |
| `:AIPromptCLIPS` | prompt CLIPS/Perl XS |
| `:AIPromptSicurezza` | prompt security |

Regole chiave:

- niente provider remoto automatico
- niente segreti nei prompt
- snapshot con allowlist e budget byte
- `.aiignore` per escludere cache, dump, log e materiale sensibile
- patch piccole, testabili, committabili

Guida completa: [docs/AI_WORKFLOW.md](/Users/gpicchiarelli/Documents/nvim-gp/docs/AI_WORKFLOW.md)

## Osservabilita

La UI espone dati sistema senza diventare rumorosa:

- dashboard: host, OS, CPU/load, RAM
- statusline: CPU, RAM, IP
- `:Sistema`: pannello dettagliato
- `:Risorse`: sintesi rapida
- `:Rete`: IP corrente

## tmux

macOS e Debian:

```zsh
ln -sfn /Users/gpicchiarelli/Documents/nvim-gp/tmux/tmux.conf ~/.tmux.conf
tmux new -A -s nvim-gp
```

Windows 11 nativo non include tmux: usare Windows Terminal tabs/panes oppure WSL2 Debian.

## Manutenzione

```zsh
make health
make update
make backup
make profile
```

## Mappa

```text
init.lua
lua/core        opzioni, diagnostica, health, autocmd
lua/plugins     lazy.nvim per domini
lua/perl        workflow Perl professionali
lua/database    PostgreSQL e dadbod
lua/expert      CLIPS e Perl XS
lua/ai          contesto AI e prompt pack
lua/lsp         server e completion
lua/dap         LLDB
lua/ui          dashboard/statusline
scripts         bootstrap, update, backup, diagnostica
docs            architettura, AI, CLIPS
```

## Documentazione

- [Architettura](/Users/gpicchiarelli/Documents/nvim-gp/docs/ARCHITETTURA.md)
- [AI workflow](/Users/gpicchiarelli/Documents/nvim-gp/docs/AI_WORKFLOW.md)
- [CLIPS](/Users/gpicchiarelli/Documents/nvim-gp/docs/CLIPS.md)

## Licenza

BSD 3-Clause. Copyright 2026 Giacomo Picchiarelli.
