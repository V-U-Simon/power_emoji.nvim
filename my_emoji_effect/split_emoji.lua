local M = {}

-- Функция для разделения строки эмоджи на отдельные символы
local function M.split_emoji(str)
    local emojis = {}
    local i = 1
    local len = #str
    while i <= len do
      local c = string.byte(str, i)
      local byte_count
      if c < 128 then
        byte_count = 1
      elseif c < 224 then
        byte_count = 2
      elseif c < 240 then
        byte_count = 3
      else
        byte_count = 4
      end
      local emoji = str:sub(i, i + byte_count - 1)
      table.insert(emojis, emoji)
      i = i + byte_count
    end
    return emojis
  end

return M