# Contribuire a Nvim GP

Nvim GP privilegia stabilita, leggibilita e workflow professionali. Le modifiche devono essere piccole, motivate e verificabili.

## Principi

- Perl, PostgreSQL e CLIPS/Perl XS hanno priorita architetturale.
- Nessuna dipendenza remota o servizio AI deve essere abilitato di default.
- Preferire lazy-loading per plugin e workflow costosi.
- Non includere segreti, dump DB, log o cache.
- Mantenere comandi e UX in italiano.

## Setup

```zsh
./scripts/install.sh
make validate
```

## Prima di aprire una PR

```zsh
make validate
git diff --check
```

Se tocchi Perl:

```zsh
prove -lr t
perlcritic --severity 5 lib t
```

Se tocchi CLIPS/Perl XS:

```vim
:CLIPSPerlXSCheck
:CLIPSPerlXSTest
```

## Stile commit

Usa messaggi brevi e imperativi:

```text
Add CLIPS XS smoke workflow
Refine AI context generation
Fix dashboard telemetry fallback
```
