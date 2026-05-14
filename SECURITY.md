# Security Policy

## Scope

Questo repository contiene configurazione Neovim, script locali, workflow Perl/PostgreSQL/CLIPS e strumenti AI-friendly.

Sono considerati security-sensitive:

- handling di segreti o stringhe di connessione;
- workflow AI e snapshot di contesto;
- shell command execution;
- database tooling;
- integrazione Perl XS CLIPS;
- script bootstrap/installazione.

## Segnalazione vulnerabilita

Apri una private vulnerability report su GitHub se disponibile, oppure contatta il maintainer senza includere segreti in issue pubbliche.

Includi:

- descrizione del rischio;
- passi minimi per riprodurre;
- impatto;
- piattaforma;
- mitigazione proposta, se nota.

## Regole repository

- Non committare `.env`, dump, database locali, chiavi, token, log o `.ai/context.md`.
- Non abilitare provider AI remoti di default.
- Non introdurre comandi distruttivi senza conferma esplicita.
- Preferire allowlist e budget quando si genera contesto per agenti.
