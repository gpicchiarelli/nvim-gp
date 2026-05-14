# CLIPS e sistemi esperti

Nvim GP integra CLIPS come dominio backend/security per sistemi esperti, regole, fatti e knowledge-base locali.

## Filetype

- `.clp`
- `.clips`

## Comandi

- `:CLIPSConsole` apre la REPL CLIPS.
- `:CLIPSCheck` carica il file corrente e intercetta errori in quickfix.
- `:CLIPSCarica` carica il file e mostra facts/agenda in terminale.
- `:CLIPSEsegui` esegue `(clear)`, `(load ...)`, `(reset)`, `(run)`, `(facts)`.
- `:CLIPSResetRun` esegue reset/run senza facts finali.
- `:CLIPSFacts` mostra i facts dopo reset.
- `:CLIPSAgenda` mostra l'agenda dopo reset.
- `:SistemaEsperto` apre uno scratch CLIPS minimale.

## Keymap

- `SPAZIO e c`: console CLIPS.
- `SPAZIO e k`: check CLIPS.
- `SPAZIO e l`: carica CLIPS.
- `SPAZIO e r`: esegui CLIPS.
- `SPAZIO e f`: facts.
- `SPAZIO e a`: agenda.
- `SPAZIO e s`: scratch sistema esperto.

Nei buffer CLIPS:

- `,c`: check.
- `,r`: esegui.
- `,l`: carica.

## Installazione

macOS/MacPorts non espone sempre un port CLIPS stabile. Il supporto IDE e quindi opt-in: se `clips` e nel `PATH`, i comandi funzionano.

Debian:

```bash
sudo apt-get install clips
```

Windows 11:

- percorso consigliato: WSL2 Debian + `sudo apt-get install clips`;
- percorso nativo: installare CLIPS manualmente e assicurarsi che `clips.exe` sia nel `PATH`.

## Workflow

1. Scrivere regole e fatti in `.clp`.
2. Usare `:CLIPSCheck` per validare caricamento.
3. Usare `:CLIPSAgenda` per capire le attivazioni.
4. Usare `:CLIPSEsegui` per ottenere esecuzione e facts finali.
5. Tenere knowledge-base, facts e test separati quando crescono.
