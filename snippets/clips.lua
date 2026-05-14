local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("rule", {
    t("(defrule "),
    i(1, "nome-regola"),
    t({ "", "  " }),
    i(2, "(fatto)"),
    t({ "", "  =>", "  " }),
    i(3, '(printout t "attivata" crlf)'),
    t({ "", ")" }),
  }),
  s("template", {
    t("(deftemplate "),
    i(1, "nome-template"),
    t({ "", "  (slot " }),
    i(2, "campo"),
    t({ ")", ")" }),
  }),
  s("facts", {
    t("(deffacts "),
    i(1, "stato-iniziale"),
    t({ "", "  " }),
    i(2, "(fatto)"),
    t({ "", ")" }),
  }),
  s("function", {
    t("(deffunction "),
    i(1, "nome-funzione"),
    t(" ("),
    i(2, "?arg"),
    t({ ")", "  " }),
    i(3, "?arg"),
    t({ "", ")" }),
  }),
}
