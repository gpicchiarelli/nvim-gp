# Nvim GP

Distribuzione Neovim professionale, locale e MacPorts-first per una workstation UNIX Perl/PostgreSQL su macOS Apple Silicon.

Supporta anche Debian e Windows 11 come target portabili, con bootstrap separati e senza diluire il profilo primario MacPorts.

## Installazione rapida

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

Su Debian il pacchetto `fd` puo essere esposto come `fdfind`; se serve, crea un alias o symlink locale verso `fd`.

### Windows 11

Da PowerShell:

```powershell
cd C:\percorso\nvim-gp
.\scripts\bootstrap_windows.ps1
.\scripts\install_windows.ps1
nvim
```

Terminale consigliato: Windows Terminal con PowerShell 7. Per un’esperienza UNIX piu fedele su Windows 11, usare WSL2 Debian e seguire il percorso Debian.

### Solo configurazione

```zsh
./scripts/install.sh
```

## Comandi italiani principali

- `:ApriProgetto`
- `:CercaFile`
- `:CercaTesto`
- `:CercaSimboli`
- `:CercaSimboliWorkspace`
- `:PaletteComandi`
- `:Formato`
- `:CriticaPerl`
- `:EseguiTest`
- `:EseguiTuttiTest`
- `:Task`
- `:EseguiTask`
- `:Outline`
- `:Todo`
- `:Audit`
- `:UndoAlbero`
- `:RestClient`
- `:RestEsegui`
- `:Sistema`
- `:Risorse`
- `:Rete`
- `:PerlTidyFile`
- `:PerlPodPreview`
- `:ApriDatabase`
- `:QueryDatabase`
- `:DebugAvvia`
- `:DebugStop`
- `:GitStato`
- `:GitDiff`
- `:Terminale`
- `:Workspace`
- `:Salute`

## Leader

- `SPAZIO f`: file
- `SPAZIO g`: grep/git
- `SPAZIO b`: database
- `SPAZIO d`: debug
- `SPAZIO t`: test
- `SPAZIO c`: codice/critic
- `SPAZIO p`: progetto
- `SPAZIO h`: help/POD/salute
- `SPAZIO l`: LSP
- `SPAZIO x`: diagnostica
- `SPAZIO q`: quickfix
- `SPAZIO r`: refactor/rest/registro
- `SPAZIO w`: workspace
- `SPAZIO z`: tmux/sessione

## Superfici IDE

- Navigazione: file tree, fuzzy finder, grep, simboli documento/workspace, outline LSP/treesitter, jump strutturale.
- Codice: LSP, completion, signature help, formatting, linting, refactoring visuale, diagnostics Trouble.
- Perl: test, critic, tidy, imports, POD, CPAN/carton, NYTProf, regex scratch, stacktrace quickfix.
- Backend: database explorer/query runner, REST client `.http`, task runner, Make/CMake, terminale integrato.
- Operativita: undo tree, yank history, sessioni, tmux, health-check, backup, update, profiling startup.
- Telemetria locale: host, OS, CPU/load, RAM, rete/IP e uptime in dashboard/statusline/pannello `:Sistema`.

## tmux

macOS e Debian:

```zsh
ln -sfn /Users/gpicchiarelli/Documents/nvim-gp/tmux/tmux.conf ~/.tmux.conf
tmux new -A -s nvim-gp
```

Windows 11 nativo non include tmux: usare Windows Terminal tabs/panes oppure WSL2 Debian per il profilo tmux completo.

## Documentazione

Vedi [docs/ARCHITETTURA.md](/Users/gpicchiarelli/Documents/nvim-gp/docs/ARCHITETTURA.md).
