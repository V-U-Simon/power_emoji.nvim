local M = {}
local config = require("power_emoji.config")
local screen = require("power_emoji.screen")
local draw = require("power_emoji.draw")
local logging = require("power_emoji.logging")


-- Clears the animation timer if it exists
local function clear_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

-- Generates a random direction for emoji movement
local function get_random_direction()
  local directions = {
    { -1, 0 },  -- вверх
    { 1, 0 },   -- вниз
    { 0, -1 },  -- влево
    { 0, 1 },   -- вправо
    { -1, -1 }, -- вверх-влево
    { -1, 1 },  -- вверх-вправо
    { 1, -1 },  -- вниз-влево
    { 1, 1 },   -- вниз-вправо
  }
  return directions[math.random(#directions)]
end


local timer = nil
local is_animating = false

local function clear_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

-- Executes the animation logic: selects a random emoji, gets the cursor position,
-- and moves the emoji in a random direction from the cursor
local function perform_animation()
  local row, col = screen.get_cursor_position()
  if not row or not col then
    logging.warn("Invalid cursor position, skipping animation.")
    return
  end

  local emoji = config.animation_symbols[math.random(#config.animation_symbols)]
  local direction = get_random_direction()

  local steps = 5  -- Количество шагов, на которое движется эмодзи
  for step = 1, steps do
    local new_row = row + direction[1] * step
    local new_col = col + direction[2] * step

    -- Проверяем, чтобы эмодзи оставались в границах экрана
    if new_row > 0 and new_row <= vim.o.lines and new_col > 0 and new_col <= vim.o.columns then
      draw.render_emoji(new_row, new_col, emoji)
    end

    -- Очищаем анимацию через интервал времени
    vim.defer_fn(function()
      draw.clear()
    end, config.animation_duration or 200)
  end

  -- Stop the timer if animation is no longer active
  if not is_animating then
    clear_timer()
  end
end

-- Starts the animation by initializing a timer and repeatedly calling perform_animation
M.trigger = function()
  if is_animating then return end
  is_animating = true

  timer = vim.loop.new_timer()
  timer:start(0, config.framerate, vim.schedule_wrap(perform_animation))

  logging.info("Animation started")
end

-- Stops the animation and clears the timer
M.stop = function()
  if not is_animating then return end
  is_animating = false
  clear_timer()

  logging.info("Animation stopped")
end

-- Add missing start method
M.start = M.trigger

return M
