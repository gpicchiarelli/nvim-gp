local M = {}

local tests = {}

function M.test(name, fn)
  table.insert(tests, { name = name, fn = fn })
end

local function fail(name, err)
  io.stderr:write("not ok - " .. name .. "\n")
  io.stderr:write(tostring(err) .. "\n")
end

function M.assert_eq(actual, expected, message)
  if actual ~= expected then
    error((message or "assert_eq failed") .. ": expected " .. vim.inspect(expected) .. ", got " .. vim.inspect(actual), 2)
  end
end

function M.assert_truthy(value, message)
  if not value then
    error(message or "assert_truthy failed", 2)
  end
end

function M.run()
  local failed = 0
  for _, item in ipairs(tests) do
    local ok, err = pcall(item.fn)
    if ok then
      print("ok - " .. item.name)
    else
      failed = failed + 1
      fail(item.name, err)
    end
  end

  if failed > 0 then
    vim.g.nvim_gp_test_failed = failed
    error(failed .. " test falliti")
  end

  print(#tests .. " test passati")
end

return M
