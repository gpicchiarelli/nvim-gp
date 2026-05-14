# Workflow AI-Friendly

Nvim GP e predisposto per agenti AI locali o esterni senza rendere l'editor dipendente da un provider remoto.

## Principi

- AI esplicita: nessuna chiamata remota automatica.
- Contesto piccolo: snapshot selettivi, non dump del repository.
- Prestazioni stabili: niente plugin AI caricati allo startup.
- Sicurezza: `.aiignore` esclude cache, log, dump, segreti e build output.
- CLIPS: knowledge-base sensibili, facts reali e dump di inferenza restano fuori dagli snapshot salvo scelta esplicita.
- Workflow umano: diff, test, review e commit piccoli.

## Comandi Neovim

- `:AIStato` mostra la policy sintetica.
- `:AIContesto` genera `.ai/context.md`.
- `:AIPolicy` apre le regole operative.
- `:AIPromptReview` prepara un prompt review.
- `:AIPromptPerformance` prepara un prompt prestazioni.
- `:AIPromptPerl` prepara un prompt Perl.
- `:AIPromptSicurezza` prepara un prompt security.

## Workflow consigliato

1. Aprire progetto e riprodurre il problema.
2. Eseguire `:AIContesto`.
3. Usare il contenuto di `.ai/context.md` con l'agente scelto.
4. Applicare patch piccole.
5. Eseguire controlli mirati.
6. Committare solo lo scope verificato.

## Prestazioni

- Il layer AI non installa provider o UI remota.
- La generazione contesto usa `rg --files`, allowlist di estensioni e budget byte.
- Gli snapshot vengono scritti solo su richiesta.
- `.ai/` e ignorabile nei commit ordinari se contiene materiale temporaneo.
