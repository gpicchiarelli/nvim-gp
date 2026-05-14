# UI Style

Nvim GP usa una direzione tipografica chiara, ispirata alle interfacce macOS: palette chiara, rumore ridotto, gerarchia netta.

## Principi

- Testo prima delle icone.
- Statusline breve, graphite, senza separatori pesanti.
- Dashboard essenziale: nome, dominio, stato macchina, azioni principali.
- Nessuna decorazione gratuita.
- Font monospaced nitidi e stabili.
- Nessuna dipendenza obbligatoria da Nerd Font.

## Font consigliati

Ordine preferito:

1. SF Mono
2. Menlo
3. JetBrainsMono Nerd Font

In GUI Neovim viene impostato:

```lua
vim.opt.guifont = "SF Mono:h15,Menlo:h14,JetBrainsMono Nerd Font:h14"
```

Nel terminale il font va configurato nel terminale stesso:

- iTerm2: SF Mono 14-15 pt, antialiasing attivo.
- Windows Terminal: Cascadia Mono o JetBrainsMono Nerd Font.
- Linux terminal: JetBrains Mono, Iosevka o equivalente monospaced.

## Densita

L'interfaccia deve restare adatta a lavoro lungo:

- niente headline enormi;
- niente palette urlanti;
- niente icone dove basta una parola;
- spaziatura controllata;
- contrasto alto ma non aggressivo.
