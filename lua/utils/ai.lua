local M = {}

M.enabled = false
M.mode = "locale"

function M.status()
  return "AI-friendly: locale, esplicito, senza chiamate remote automatiche."
end

function M.policy()
  return {
    "AI policy Nvim GP",
    "",
    "- Nessun provider remoto e abilitato di default.",
    "- Nessun segreto deve entrare in prompt o snapshot.",
    "- Il contesto viene generato su richiesta con allowlist e ignore file.",
    "- Output pesanti, cache, database dump e vendor sono esclusi.",
    "- Le modifiche AI devono passare da diff, test e commit piccoli.",
  }
end

return M
