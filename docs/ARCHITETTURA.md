# Nvim GP: Architettura

Nvim GP e una distribuzione Neovim locale, terminal-native e MacPorts-first, pensata come cockpit UNIX per sviluppo Perl, PostgreSQL e backend/security engineering.

Il target primario resta macOS Apple Silicon con MacPorts. Debian e Windows 11 sono target supportati tramite profili di bootstrap separati: Debian come UNIX peer operativo, Windows 11 come ambiente nativo PowerShell/winget oppure, preferibilmente per tmux, WSL2 Debian.

## Roadmap

1. Fondazione stabile: opzioni Neovim conservative, lazy.nvim, diagnostica coerente, sessioni, terminale e tmux.
2. Perl-first: Perl::LanguageServer, Perl::Critic severity 5, perltidy, prove, carton, cpanm, POD, NYTProf, quickfix.
3. Database-first: vim-dadbod, PostgreSQL helpers, completamento SQL, query buffer, schema explorer.
4. Toolchain enterprise: clangd/LLDB/CMake, PHPActor/Composer/PHPUnit, web stack essenziale, sourcekit-lsp.
5. Superfici IDE complete: outline, todo/audit, refactoring, REST client, task runner, undo tree, yank history, jump strutturale.
6. Sistemi esperti: supporto CLIPS per regole, facts, agenda, REPL, run/check e binding Perl XS.
7. Operativita: script MacPorts, Debian apt, Windows winget/PowerShell, health-check, diagnosi, backup, startup profiling.
8. Osservabilita locale: dashboard e statusline con host, OS, CPU/load, RAM, rete/IP e uptime.
9. AI-friendly: contesto locale selettivo, prompt pack, policy agenti e nessun provider remoto caricato di default.
10. Futuro: integrazioni AI opzionali tramite moduli isolati e lazy-loaded.

## Struttura

```text
init.lua
lua/core        disciplina editor, bootstrap, diagnostica, health
lua/plugins     dichiarazioni lazy.nvim per dominio
lua/lsp         server, completion e attach
lua/dap         debugger LLDB
lua/database    dadbod e helper DBA
lua/perl        workflow Perl professionali
lua/expert      sistemi esperti e CLIPS
lua/ide         azioni IDE trasversali
lua/ai          workflow AI-friendly locale
lua/languages   treesitter, formatter, lint
lua/keymaps     leader SPACE e which-key italiano
lua/commands    comandi italiani
lua/workspace   task/sessioni/progetti
lua/utils       job async e quickfix
scripts         bootstrap per piattaforma, update, backup, health, diagnostica
tmux            profilo tmux
```

## Rationale tecnico

- MacPorts e l'unica fonte di sistema: riduce drift e rende la workstation auditabile.
- Debian usa `apt` solo nel proprio bootstrap; Windows 11 usa `winget` solo nei propri script PowerShell.
- Neovim resta terminal-native: niente Electron, niente assunzioni VS Code, niente runtime superflui.
- lazy.nvim gestisce caricamento ritardato per dominio, con UI pronta subito e strumenti pesanti caricati a comando/filetype.
- Perl e trattato come piattaforma primaria, non come linguaggio secondario: LSP, critic, tidy, test, POD e profiling hanno comandi dedicati.
- PostgreSQL e il DB predefinito, con MariaDB/MySQL, SQLite, MSSQL e Oracle lasciati compatibili tramite stringhe dadbod.
- Le capacita IDE trasversali sono isolate nel layer `plugins.ide` e `lua/ide`, per evitare che il dominio Perl o DB diventi un contenitore indistinto.

## Superfici IDE

- Navigazione progetto: Neo-tree, Telescope, Harpoon, Flash, Aerial.
- Navigazione semantica: LSP definitions/references/rename, simboli documento/workspace, outline persistente.
- Qualita codice: Conform, nvim-lint, Trouble, Todo/Audit, quickfix disciplinato.
- Refactoring: refactoring.nvim per estrazioni e inline dove supportato da treesitter.
- Test e task: workflow Perl dedicato piu Overseer per Make/CMake/script di progetto.
- Backend/API: dadbod per database e Kulala per richieste `.http` locali.
- Sistemi esperti: CLIPS `.clp`, snippets, syntax, REPL, check/run, facts, agenda e workflow Perl XS/Test2.
- Storico operativo: undo tree, yank ring, sessioni, tmux.
- Focus: Zen/Twilight per lettura o review lunga senza alterare la configurazione base.
- Osservabilita: modulo `utils.telemetry` con cache leggera per non rallentare statusline e pannello `:Sistema` per dettagli.

## UX intuitiva e leggibile

- La dashboard non e una landing page decorativa: mostra azioni operative e stato macchina.
- La statusline resta corta: file, diagnostica, CPU/load, RAM, rete, posizione.
- I dettagli rumorosi stanno in `:Sistema`, non sempre a schermo.
- I comandi italiani sono la superficie primaria: `:Sistema`, `:Risorse`, `:Rete`, `:Salute`.
- I gruppi `SPAZIO` restano mnemonici: `s` per simboli/sistema, `t` per test/task, `b` per database, `c` per codice.

## AI-friendly architecture

- `lua/ai/context.lua` genera snapshot contestuali on-demand.
- `.aiignore` e `.gitignore` impediscono di trascinare cache, log, dump e segreti.
- `AGENTS.md` definisce regole operative per agenti.
- `docs/AI_WORKFLOW.md` documenta workflow e prestazioni.
- Nessun plugin AI remoto e installato o caricato di default: eventuali provider futuri devono vivere in moduli separati, lazy-loaded e opt-in.

## Matrice piattaforme

| Piattaforma | Stato | Package manager | Terminale | Note |
| --- | --- | --- | --- | --- |
| macOS Apple Silicon | primario | MacPorts | iTerm2 + tmux | profilo piu curato e deterministico |
| Debian | supportato | apt + cpanm mirato | terminale UNIX + tmux | `fd` puo chiamarsi `fdfind` |
| Windows 11 nativo | supportato | winget + cpanm | Windows Terminal + PowerShell 7 | tmux non nativo; consigliato WSL2 per parita UNIX |
| Windows 11 + WSL2 Debian | consigliato su Windows | apt + cpanm mirato | Windows Terminal + tmux in WSL | esperienza piu vicina al cockpit UNIX |

## Bootstrap per piattaforma

```zsh
# macOS
./scripts/bootstrap_macports.sh
./scripts/install.sh

# Debian
./scripts/bootstrap_debian.sh
./scripts/install.sh
```

```powershell
# Windows 11 nativo
.\scripts\bootstrap_windows.ps1
.\scripts\install_windows.ps1
.\scripts\health-check.ps1
```

## Convenzioni

- Leader: `SPAZIO`.
- Comandi utente in italiano.
- File Lua piccoli, responsabilita separate.
- Quickfix per output auditabile, notifiche solo per esito operativo.
- Severity Perl::Critic: 5.
- Formattazione su save solo dove ragionevolmente deterministica.

## Sicurezza

- Nessuna telemetria intenzionale.
- Nessun package manager alternativo per strumenti di sistema.
- Package manager separati per target: MacPorts, apt, winget. Non mischiare sorgenti sulla stessa piattaforma salvo moduli Perl installati con `cpanm` quando il repository OS non offre pacchetti adeguati.
- Connessioni DB salvate in `stdpath("data")/dadbod`, fuori dalla configurazione versionabile.
- Segreti DB via variabili ambiente o file locali non committati.
- Override progetto preferibilmente in file locali esclusi da git.

## Upgrade strategy

1. `make backup`
2. `make update`
3. `make health`
4. Verifica Perl con `:CriticaPerl`, `:EseguiTest`, `:PerlPodCheck`.
5. Profilo startup con `make profile` se la UX degrada.

## Disaster recovery

- Backup: `scripts/backup.sh`.
- Windows: copiare `%LOCALAPPDATA%\nvim` o usare un archivio esterno equivalente.
- Config installata come symlink: ripristino semplice spostando il symlink.
- Dadbod state separato in data dir.
- Lazy plugins ricostruibili con `nvim --headless "+Lazy! sync" +qa`.
