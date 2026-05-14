local jobs = require("utils.jobs")
local qf = require("utils.quickfix")

local M = {}

local function current_file()
  return vim.fn.expand("%:p")
end

local function project_root()
  local markers = { "cpanfile", "Makefile.PL", "dist.ini", "minil.toml", ".git" }
  local found = vim.fs.find(markers, { upward = true, path = vim.fn.expand("%:p:h") })[1]
  return found and vim.fs.dirname(found) or vim.loop.cwd()
end

function M.prove_file()
  local file = current_file()
  jobs.quickfix({ "prove", "-lv", file }, { title = "prove " .. vim.fn.fnamemodify(file, ":t") })
end

function M.prove_all()
  jobs.quickfix({ "prove", "-lr", "t" }, { cwd = project_root(), title = "prove t/" })
end

function M.critic_file()
  local file = current_file()
  jobs.quickfix({ "perlcritic", "--severity", "5", "--verbose", "%f:%l:%c:%m\n", file }, {
    title = "Perl::Critic severity 5",
    parser = qf.colon_parser,
  })
end

function M.tidy_file()
  vim.cmd.write()
  jobs.notify({ "perltidy", "-b", current_file() }, { title = "perltidy" })
end

function M.imports_file()
  jobs.quickfix({ "perlimports", "--lint", current_file() }, { title = "perlimports" })
end

function M.pod_check()
  jobs.quickfix({ "podchecker", current_file() }, { title = "podchecker" })
end

function M.pod_preview()
  local file = current_file()
  vim.cmd("botright split")
  vim.cmd("terminal perldoc -F " .. vim.fn.shellescape(file))
  vim.cmd("startinsert")
end

function M.nytprof()
  local file = current_file()
  jobs.notify({ "perl", "-d:NYTProf", file }, { cwd = project_root(), title = "Devel::NYTProf" })
end

function M.carton_install()
  jobs.notify({ "carton", "install" }, { cwd = project_root(), title = "carton install" })
end

function M.cpanm_module()
  vim.ui.input({ prompt = "Modulo CPAN: " }, function(module)
    if module and module ~= "" then
      jobs.notify({ "cpanm", module }, { cwd = project_root(), title = "cpanm " .. module })
    end
  end)
end

function M.regex_scratch()
  vim.cmd("vnew")
  vim.bo.filetype = "perl"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "use v5.38;",
    "use strict;",
    "use warnings;",
    "",
    "my $testo = q{};",
    "my $regex = qr//;",
    "",
    "if ($testo =~ $regex) {",
    "    say 'match';",
    "}",
  })
end

function M.stacktrace_to_quickfix()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local items = {}
  for _, line in ipairs(lines) do
    local file, lnum = line:match("at%s+([^%s]+)%s+line%s+(%d+)")
    if file and lnum then
      table.insert(items, { filename = file, lnum = tonumber(lnum), text = line })
    end
  end
  vim.fn.setqflist(items, "r", { title = "Stacktrace Perl" })
  vim.cmd.copen()
end

return M
