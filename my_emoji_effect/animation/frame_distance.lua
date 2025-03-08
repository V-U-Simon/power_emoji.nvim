-- file: my_emoji_effect/animation/frame_distance.lua
local M = {}

--- Рассчитывает расстояние, которое фрейм пролетит за всю анимацию
---@param steps number
---@param duration number
---@param distance_factor number -- множитель (из конфига)
---@return number total_distance
function M.calculate(steps, duration, distance_factor)
  -- Пример: расстояние ~ (duration/1000) * (steps/5) * distance_factor
  -- return (duration / 1000) * (steps / 5) * distance_factor
  return distance_factor
end

return M
