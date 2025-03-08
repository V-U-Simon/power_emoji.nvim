-- file: my_emoji_effect/animation/init.lua

local frame = require("my_emoji_effect.animation.frame")
local frame_direction = require("my_emoji_effect.animation.frame_direction")
local frame_speed = require("my_emoji_effect.animation.frame_speed")
local frame_smooth = require("my_emoji_effect.animation.frame_smooth")
local frame_opacity = require("my_emoji_effect.animation.frame_opacity")
local frame_distance = require("my_emoji_effect.animation.frame_distance")

local M = {}

--- Запускаем анимацию эмодзи (run)
---@param emoji string    Эмодзи
---@param duration number Длительность анимации (мс)
---@param steps number    Количество шагов
---@param offset_x number Начальное смещение по X
---@param offset_y number Начальное смещение по Y
---@param distance_factor number множитель дистанции
---@param twist_factor number множитель "закрутки" (закручивает угол)
function M.run(emoji, duration, steps, offset_x, offset_y, distance_factor, twist_factor)
  -- Создаём плавающее окно и получаем win_id и bufnr
  local win_id, bufnr = frame.create(emoji, offset_x, offset_y)

  -- Если шагов слишком мало, сделаем "по умолчанию" побольше:
  if steps < 5 then
    steps = 30
  end

  local step_duration = math.floor(duration / steps)
  -- Случайный начальный угол:
  local angle = frame_direction.random_angle()
  -- Базовая "скорость":
  local spd = frame_speed.get_speed()
  -- Длина, которую пролетит за всё время:
  local total_distance = frame_distance.calculate(steps, duration, distance_factor)

  -- Таймер для плавной анимации
  local timer = vim.loop.new_timer()
  local step_i = 0

  timer:start(
    0,            -- задержка перед первым запуском
    step_duration, -- период повторения (мс)
    vim.schedule_wrap(function()
      step_i = step_i + 1

      -- Считаем прогресс 0..1
      local progress = frame_smooth.progress(step_i, steps)

      -- Добавим "twist": угол будет чуть-чуть увеличиваться
      angle = angle + (twist_factor * 0.05)  -- меняйте коэффициент 0.05 на свой вкус

      -- Координаты (dx, dy) на каждый шаг:
      local step_dist = (total_distance / steps) * spd
      local dx = step_dist * math.cos(angle)
      local dy = step_dist * math.sin(angle)

      local new_row = offset_y + dy * step_i
      local new_col = offset_x + dx * step_i

      -- Новая прозрачность (0 - непрозрачно, 100 - "прозрачно")
      local new_blend = frame_opacity.calculate(progress)

      -- Обновим окно
      frame.update(win_id, new_row, new_col, new_blend)

      if step_i >= steps then
        -- Закрываем окно с небольшим запасом
        frame.close_after(win_id, 50)
        timer:stop()
        timer:close()
      end

    end)
  )
end

return M
