local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("strict", {
    t({ "use v5.38;", "use strict;", "use warnings;", "use feature qw(signatures);", "no warnings qw(experimental::signatures);", "" }),
  }),
  s("test2", {
    t({ "use v5.38;", "use strict;", "use warnings;", "use Test2::V0;", "", "" }),
    i(1, "ok 1, 'caricato';"),
    t({ "", "", "done_testing;" }),
  }),
  s("package", {
    t({ "package " }),
    i(1, "My::Module"),
    t({ ";", "", "use v5.38;", "use strict;", "use warnings;", "", "1;", "" }),
  }),
  s("clipsxs", {
    t({ "use v5.38;", "use strict;", "use warnings;", "use Test2::V0;", "" }),
    t("use "),
    i(1, "CLIPS"),
    t({ ";", "", "ok 1, 'CLIPS XS caricato';", "", "done_testing;" }),
  }),
}
