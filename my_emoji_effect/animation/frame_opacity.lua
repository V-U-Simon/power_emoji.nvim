-- file: my_emoji_effect/animation/frame_opacity.lua
local M = {}

--- Рассчитывает степень прозрачности (winblend от 0 до 100)
---@param progress number число от 0 до 1
function M.calculate(progress)
  return math.floor(progress * 100)
end

return M
