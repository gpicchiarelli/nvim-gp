# CLIPS e sistemi esperti

Nvim GP integra CLIPS come dominio backend/security per sistemi esperti, regole, fatti e knowledge-base locali.

Nel nostro ambiente il percorso principale e il modulo Perl XS per CLIPS. Il binario `clips` resta utile per REPL, diagnostica isolata e confronto, ma i workflow applicativi devono privilegiare Perl, `prove`, `Test2::V0` e il binding XS.

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
- `:CLIPSPerlXSCheck` verifica che il modulo Perl XS sia caricabile.
- `:CLIPSPerlXSVersione` mostra la versione dichiarata dal modulo.
- `:CLIPSPerlXSDoc` apre `perldoc -m` sul modulo XS.
- `:CLIPSPerlXSTest` esegue `prove -lr t`.
- `:CLIPSPerlXSScratch` crea uno scratch Test2 per il binding XS.

## Keymap

- `SPAZIO e c`: console CLIPS.
- `SPAZIO e k`: check CLIPS.
- `SPAZIO e l`: carica CLIPS.
- `SPAZIO e r`: esegui CLIPS.
- `SPAZIO e f`: facts.
- `SPAZIO e a`: agenda.
- `SPAZIO e s`: scratch sistema esperto.
- `SPAZIO e x`: check Perl XS.
- `SPAZIO e X`: test Perl XS.

Nei buffer CLIPS:

- `,c`: check.
- `,r`: esegui.
- `,l`: carica.

## Installazione

macOS/MacPorts non espone sempre un port CLIPS stabile. Il supporto IDE e quindi opt-in: se `clips` e nel `PATH`, i comandi funzionano.

Per il modulo XS, il nome predefinito e `CLIPS`. Se il modulo del progetto usa un nome diverso:

```lua
vim.g.nvim_gp_clips_xs_module = "Nome::Modulo::XS"
```

Oppure:

```zsh
export NVIM_GP_CLIPS_XS_MODULE='Nome::Modulo::XS'
```

Debian:

```bash
sudo apt-get install clips
```

Windows 11:

- percorso consigliato: WSL2 Debian + `sudo apt-get install clips`;
- percorso nativo: installare CLIPS manualmente e assicurarsi che `clips.exe` sia nel `PATH`.

## Workflow

1. Verificare il binding con `:CLIPSPerlXSCheck`.
2. Scrivere regole e fatti in `.clp`.
3. Usare `:CLIPSCheck` quando serve isolare un problema nel runtime CLIPS standalone.
4. Scrivere smoke/integration test Perl con `Test2::V0`.
5. Eseguire `:CLIPSPerlXSTest` come workflow principale.
6. Usare `:CLIPSAgenda` e `:CLIPSFacts` per debug inferenziale.
7. Tenere knowledge-base, facts e test separati quando crescono.
