return {
  review = {
    "# Prompt review",
    "",
    "Agisci come reviewer senior UNIX/Perl/security.",
    "Priorita: bug, regressioni, sicurezza, performance, test mancanti.",
    "Rispondi con findings ordinati per severita e riferimenti file/linea.",
  },
  performance = {
    "# Prompt performance",
    "",
    "Analizza prestazioni, startup, lazy-loading, processi esterni e I/O.",
    "Proponi interventi piccoli, misurabili e reversibili.",
    "Non introdurre dipendenze remote o demoni persistenti non richiesti.",
  },
  perl = {
    "# Prompt Perl",
    "",
    "Mantieni codice Perl auditable: strict, warnings, Test2::V0, perltidy, Perl::Critic severity 5.",
    "Preferisci leggibilita, error handling esplicito e API conservative.",
  },
  sicurezza = {
    "# Prompt sicurezza",
    "",
    "Cerca segreti, input non validati, shell injection, path traversal e logging sensibile.",
    "Non stampare segreti. Indica solo pattern e posizione.",
  },
}
