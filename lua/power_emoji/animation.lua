local M = {}
local config = require("power_emoji.config")
local screen = require("power_emoji.screen")
local draw = require("power_emoji.draw")
local logging = require("power_emoji.logging")

local timer = nil
local is_animating = false

local function clear_timer()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end
end

local function perform_animation()
  local row, col = screen.get_cursor_position()
  local emoji = config.animation_symbols[math.random(#config.animation_symbols)]

  logging.debug(string.format("Animating emoji '%s' at position (%d, %d)", emoji, row, col))

  draw.render_emoji(row, col, emoji)

  if not is_animating then
    clear_timer()
  end
end

M.trigger = function()
  if is_animating then return end
  is_animating = true

  timer = vim.loop.new_timer()
  timer:start(0, config.framerate, vim.schedule_wrap(perform_animation))

  logging.info("Animation started")
end

M.stop = function()
  if not is_animating then return end
  is_animating = false
  clear_timer()

  logging.info("Animation stopped")
end

return M
