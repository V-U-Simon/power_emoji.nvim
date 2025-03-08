-- -- file: my_emoji_effect/animation/frame_direction.lua
-- local M = {}

-- --- Генерирует случайный угол полёта (от 0 до 2π)
-- function M.random_angle()
--   math.randomseed(os.time() + vim.fn.float2nr(vim.loop.hrtime() % 1000000))
--   return math.random() * (2 * math.pi)
-- end

-- return M


local M = {}

--- Генерирует угол полёта, направленный вверх (+/- 40°)
function M.random_angle()
  math.randomseed(os.time() + vim.fn.float2nr(vim.loop.hrtime() % 1000000))

  local center_angle = math.pi / 2           -- 90° в радианах
  local delta = math.rad(40)                 -- 40° в радианах
  local min_angle = center_angle - delta
  local max_angle = center_angle + delta

  -- Возвращаем случайное значение в диапазоне [min_angle, max_angle]
  return min_angle + math.random() * (max_angle - min_angle)
end

return M
