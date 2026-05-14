# Nvim GP

[![CI](https://github.com/gpicchiarelli/nvim-gp/actions/workflows/ci.yml/badge.svg)](https://github.com/gpicchiarelli/nvim-gp/actions/workflows/ci.yml)
[![License: BSD-3-Clause](https://img.shields.io/badge/license-BSD--3--Clause-2f6f73.svg)](LICENSE)
![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-57A143?logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-config-2C2D72?logo=lua&logoColor=white)
![lazy.nvim](https://img.shields.io/badge/plugin%20manager-lazy.nvim-2f6f73)
![local](https://img.shields.io/badge/runtime-local-111111)
![terminal-native](https://img.shields.io/badge/interface-terminal--native-111111)
![Electron free](https://img.shields.io/badge/Electron-free-111111)

![macOS](https://img.shields.io/badge/macOS-Apple%20Silicon-000000?logo=apple&logoColor=white)
![MacPorts](https://img.shields.io/badge/MacPorts-first-2f6f73)
![Debian](https://img.shields.io/badge/Debian-supported-A81D33?logo=debian&logoColor=white)
![Windows 11](https://img.shields.io/badge/Windows%2011-supported-0078D4?logo=windows11&logoColor=white)
![zsh](https://img.shields.io/badge/shell-zsh-111111)
![tmux](https://img.shields.io/badge/tmux-integrated-1BB91F?logo=tmux&logoColor=white)

![Perl](https://img.shields.io/badge/Perl-primary-39457E?logo=perl&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-primary-4169E1?logo=postgresql&logoColor=white)
![CLIPS](https://img.shields.io/badge/CLIPS-expert%20systems-2f6f73)
![C](https://img.shields.io/badge/C-supported-A8B9CC?logo=c&logoColor=111111)
![C++](https://img.shields.io/badge/C%2B%2B-supported-00599C?logo=cplusplus&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-supported-777BB4?logo=php&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-supported-F7DF1E?logo=javascript&logoColor=111111)
![TypeScript](https://img.shields.io/badge/TypeScript-supported-3178C6?logo=typescript&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-supported-F05138?logo=swift&logoColor=white)

![MariaDB](https://img.shields.io/badge/MariaDB-supported-003545?logo=mariadb&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-supported-003B57?logo=sqlite&logoColor=white)
![MSSQL](https://img.shields.io/badge/MSSQL-driver%20local-CC2927)
![Oracle](https://img.shields.io/badge/Oracle-driver%20local-F80000?logo=oracle&logoColor=white)

![LSP](https://img.shields.io/badge/LSP-enabled-2f6f73)
![DAP](https://img.shields.io/badge/DAP-enabled-2f6f73)
![Tree-sitter](https://img.shields.io/badge/tree--sitter-enabled-2f6f73)
![Perl::Critic](https://img.shields.io/badge/Perl::Critic-severity%205-39457E)
![perltidy](https://img.shields.io/badge/perltidy-enabled-39457E)
![prove](https://img.shields.io/badge/prove-enabled-39457E)
![dadbod](https://img.shields.io/badge/vim--dadbod-enabled-4169E1)
![AI local](https://img.shields.io/badge/AI-local%20context-111111)

![lint](https://img.shields.io/badge/make-lint-2f6f73)
![smoke](https://img.shields.io/badge/make-smoke-2f6f73)
![test](https://img.shields.io/badge/make-test-2f6f73)
![validate](https://img.shields.io/badge/make-validate-2f6f73)
![install smoke](https://img.shields.io/badge/install%20smoke-linux%20%7C%20macOS%20%7C%20Windows-2f6f73)
![feature contracts](https://img.shields.io/badge/feature-contracts-111111)
![gate based installers](https://img.shields.io/badge/installers-gate--based-111111)

Distribuzione Neovim locale per sviluppo Perl, PostgreSQL, CLIPS, C/C++, PHP, web stack e Swift.

## Requisiti

| Componente | Requisito |
| --- | --- |
| Editor | Neovim 0.10+ |
| Shell | zsh |
| Terminale macOS | iTerm2 |
| Multiplexer | tmux |
| Package manager macOS | MacPorts |
| Font consigliato | SF Mono |
| Repository | Git |

## Piattaforme

| Piattaforma | Stato | Note |
| --- | --- | --- |
| macOS Apple Silicon | primario | MacPorts-first |
| Debian | supportato | bootstrap dedicato |
| Windows 11 | supportato | nativo PowerShell; WSL2 Debian consigliato per tmux |

## Dominio

| Priorita | Area |
| --- | --- |
| 1 | Perl |
| 2 | PostgreSQL |
| 3 | C/C++ |
| 4 | PHP |
| 5 | Web stack |
| 6 | Swift |

## Funzioni

| Area | Componenti |
| --- | --- |
| Plugin manager | `lazy.nvim` |
| LSP | Perl, SQL, C/C++, PHP, web, Swift |
| DAP | LLDB e adapter configurabili |
| Formattazione | `perltidy`, formatter linguaggio-specifici |
| Lint | `perlcritic`, toolchain locali |
| Test | `prove`, PHPUnit, task runner |
| Database | `vim-dadbod`, `vim-dadbod-ui`, completamento SQL |
| Git | stato, diff, hunks, blame, history |
| Ricerca | fuzzy finding, grep, simboli |
| Syntax tree | nvim-treesitter, parser locali, tree-sitter-cli |
| UI | dashboard, statusline, bufferline, diagnostics |
| Sistema | CPU/load, RAM, rete/IP, host, uptime |
| Sessioni | workspace, tmux, session management |
| AI | contesto locale, prompt pack, policy, `.aiignore` |
| CLIPS | syntax, snippets, REPL, check, run, agenda, Perl XS |

## Perl

| Funzione | Tool |
| --- | --- |
| LSP | `Perl::LanguageServer` |
| Critic | `Perl::Critic` |
| Format | `Perl::Tidy`, `perltidy` |
| Test | `prove`, `Test2::V0` |
| Dependency management | `carton`, `cpanm` |
| Import cleanup | `App::perlimports` |
| Profiling | `Devel::NYTProf` |
| Documentation | POD, `podchecker`, `Pod::Simple` |

Comandi Perl:

```vim
:CriticaPerl
:PerlTidyFile
:EseguiTest
:EseguiTuttiTest
:PerlPodCheck
:PerlPodPreview
```

## PostgreSQL

PostgreSQL e il database primario. L'integrazione usa `vim-dadbod` e `vim-dadbod-ui`.

Comandi database:

```vim
:ApriDatabase
:QueryDatabase
```

Backend database compatibili tramite dadbod:

| Database | Stato |
| --- | --- |
| PostgreSQL | primario |
| MariaDB/MySQL | supportato |
| SQLite | supportato |
| MSSQL | supportato tramite driver locale |
| Oracle | supportato tramite driver locale |

## CLIPS

CLIPS e supportato come sistema esperto locale e come integrazione Perl XS.

Comandi CLIPS:

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

Modulo XS predefinito:

```lua
vim.g.nvim_gp_clips_xs_module = "CLIPS"
```

Override via ambiente:

```zsh
export NVIM_GP_CLIPS_XS_MODULE='Nome::Modulo::XS'
```

Documentazione: [docs/CLIPS.md](docs/CLIPS.md).

## AI

La configurazione AI non abilita provider remoti. Le funzioni disponibili generano contesto e prompt locali.

Comandi AI:

```vim
:AIStato
:AIContesto
:AIPolicy
:AIPromptReview
:AIPromptPerformance
:AIPromptPerl
:AIPromptCLIPS
:AIPromptSicurezza
```

Output principale:

```text
.ai/context.md
```

File di esclusione:

```text
.aiignore
```

Documentazione: [docs/AI_WORKFLOW.md](docs/AI_WORKFLOW.md).

## Installazione macOS

```zsh
git clone https://github.com/gpicchiarelli/nvim-gp.git
cd nvim-gp
make ensure-macports
./scripts/install.sh
nvim
```

`make ensure-macports` usa gate di capacita: verifica comando, versione minima e moduli Perl prima di installare. Un `git`, un `perl` o un tool gia sufficiente non viene reinstallato via MacPorts. Su macOS usa `sudo -A` con askpass grafico quando sono richiesti privilegi amministrativi.

Dry-run:

```zsh
NVIM_GP_DRY_RUN=1 make ensure-macports
```

Installazione solo configurazione:

```zsh
./scripts/install.sh
```

## Installazione Debian

```bash
git clone https://github.com/gpicchiarelli/nvim-gp.git
cd nvim-gp
./scripts/bootstrap_debian.sh
./scripts/install.sh
nvim
```

## Installazione Windows 11

```powershell
cd C:\percorso\nvim-gp
.\scripts\bootstrap_windows.ps1
.\scripts\install_windows.ps1
nvim
```

## Keymap

Leader: `SPAZIO`.

| Prefisso | Area |
| --- | --- |
| `SPAZIO f` | file |
| `SPAZIO g` | grep, git, comandi |
| `SPAZIO b` | database |
| `SPAZIO d` | debug |
| `SPAZIO e` | CLIPS |
| `SPAZIO t` | test e task |
| `SPAZIO c` | codice, format, critic, audit |
| `SPAZIO p` | progetto |
| `SPAZIO h` | help, POD, health |
| `SPAZIO l` | LSP |
| `SPAZIO s` | simboli e sistema |
| `SPAZIO a` | AI locale |
| `SPAZIO r` | refactor, REST, registro |
| `SPAZIO q` | quickfix |
| `SPAZIO w` | workspace |
| `SPAZIO z` | tmux, focus, sessione |

Comandi generali:

```vim
:ApriProgetto
:CercaFile
:CercaTesto
:Formato
:ApriDatabase
:Sistema
:Risorse
:Rete
:Terminale
:Workspace
```

## Test

Comandi obbligatori per validazione locale:

```zsh
make lint
make smoke
make test
make validate
```

| Target | Controllo |
| --- | --- |
| `make lint` | Lua, shell, newline, file monoriga sospetti, `git diff --check` |
| `make smoke` | avvio Neovim fase 0 senza plugin |
| `make test` | test headless su core, moduli e feature contracts |
| `make validate` | lint + test |
| `make health` | tool locali disponibili |
| `make format` | formattazione con tool disponibili |
| `make profile` | startup profiling |

CI GitHub Actions:

| Job | Runner | Controllo |
| --- | --- | --- |
| `Validate repository` | Ubuntu | `make validate` |
| `Deep validation (linux)` | Ubuntu | lint, smoke, test, validate, bootstrap Debian dry-run, `Lazy sync`, startup completo, feature contracts |
| `Deep validation (macos)` | macOS 14 | lint, smoke, test, validate, controllo MacPorts script, `Lazy sync`, startup completo, feature contracts |
| `Deep validation (windows)` | Windows latest | parsing PowerShell, install temporanea, bootstrap Windows dry-run |
| `Install smoke (linux)` | Ubuntu | `scripts/install.sh` in directory temporanea |
| `Install smoke (macos)` | macOS 14 | `scripts/install.sh` in directory temporanea |
| `Install smoke (windows)` | Windows latest | `scripts/install_windows.ps1` con link/junction temporaneo |

Feature contract:

```text
tests/features.lua
tests/test_feature_matrix.lua
```

Ogni feature dichiarata deve avere documentazione, file, moduli e comandi attesi.

## Struttura

```text
init.lua
lua/core        opzioni, diagnostica, health, autocmd
lua/plugins     dichiarazioni lazy.nvim
lua/perl        workflow Perl
lua/database    dadbod e PostgreSQL
lua/expert      CLIPS e Perl XS
lua/ai          contesto AI e prompt locali
lua/lsp         server e completion
lua/dap         debug
lua/ui          dashboard e statusline
scripts         installazione, health, lint, smoke
docs            note tecniche
tests           smoke, moduli, feature contracts
tmux            configurazione tmux
```

## tmux

```zsh
ln -sfn "$PWD/tmux/tmux.conf" ~/.tmux.conf
tmux new -A -s nvim-gp
```

## Documentazione

| Documento | Percorso |
| --- | --- |
| Architettura | [docs/ARCHITETTURA.md](docs/ARCHITETTURA.md) |
| AI workflow | [docs/AI_WORKFLOW.md](docs/AI_WORKFLOW.md) |
| CLIPS | [docs/CLIPS.md](docs/CLIPS.md) |
| UI style | [docs/UI_STYLE.md](docs/UI_STYLE.md) |
| Contributing | [CONTRIBUTING.md](CONTRIBUTING.md) |
| Security | [SECURITY.md](SECURITY.md) |

## Licenza

BSD 3-Clause. Copyright 2026 Giacomo Picchiarelli.
