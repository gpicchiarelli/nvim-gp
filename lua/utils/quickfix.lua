local M = {}

function M.colon_parser(lines)
  local items = {}
  for _, line in ipairs(lines) do
    local file, lnum, col, text = line:match("^([^:]+):(%d+):(%d+):(.*)$")
    if file then
      table.insert(items, {
        filename = file,
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = vim.trim(text),
      })
    else
      table.insert(items, { text = line })
    end
  end
  return items
end

return M
