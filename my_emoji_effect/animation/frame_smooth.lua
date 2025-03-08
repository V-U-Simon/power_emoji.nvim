-- file: my_emoji_effect/animation/frame_smooth.lua
local M = {}

--- Вычисляет прогресс анимации (0..1)
---@param step_i number текущий шаг
---@param steps number всего шагов
function M.progress(step_i, steps)
  return step_i / steps
end

return M
