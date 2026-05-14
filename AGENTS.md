# AGENTS.md

## Ruolo del repository

Questa configurazione e una distribuzione Neovim professionale Perl/PostgreSQL-first. Deve restare locale, terminal-native, sobria, riproducibile e leggibile.

## Regole per agenti AI

- Non abilitare provider remoti o telemetria automatica senza richiesta esplicita.
- Preferire cambi piccoli, motivati e verificabili.
- Non modificare file non correlati al task.
- Non includere segreti, dump DB, cache o log nei prompt.
- Usare `rg` per cercare.
- Usare `apply_patch` o patch leggibili per modifiche manuali.
- Dopo modifiche Lua, verificare con Neovim headless:

```zsh
XDG_STATE_HOME=.state XDG_DATA_HOME=.data XDG_CACHE_HOME=.cache \
nvim --headless -u NONE '+lua for _, f in ipairs(vim.fn.glob("**/*.lua", false, true)) do local ok, err = loadfile(f); if not ok then error(f .. ": " .. err) end end' +qa
```

## Perl

- Mantenere `strict`, `warnings`, `perltidy`, `Perl::Critic` severity 5.
- Test preferiti: `prove -lr t`.
- Preferire `Test2::V0`.

## Performance

- Nessun plugin deve caricare a startup se non necessario.
- Preferire lazy-loading per `cmd`, `ft`, `keys` o eventi specifici.
- Evitare job sincroni in statusline/autocmd frequenti.
- Cache esplicita per dati sistema o scansioni repository.
