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

-- Add start method for animation
M.start = M.trigger

-- Add the setup method for plugin configuration
-- M.setup = function(opts)
--   opts = opts or {}
--   for key, value in pairs(opts) do
--     if config[key] ~= nil then
--       config[key] = value
--     end
--   end

--   vim.api.nvim_create_user_command("PowerEmojiToggle", function()
--     if is_animating then
--       M.stop()
--     else
--       M.trigger()
--     end
--   end, {})

--   logging.info("PowerEmoji plugin configured")
-- end

-- Configures the plugin and registers the PowerEmojiToggle command
M.setup = function(opts)
  opts = opts or {}
  for key, value in pairs(opts) do
    if config[key] ~= nil then
      config[key] = value
    end
  end

  -- Register a command to toggle animation manually
  vim.api.nvim_create_user_command("PowerEmojiToggle", function()
    if is_animating then
      M.stop()
    else
      M.trigger()
    end
  end, {})

  -- Register autocmd for animation on text change in insert mode
  vim.api.nvim_create_autocmd("TextChangedI", {
    callback = function()
      M.trigger()
    end,
    desc = "Trigger animation on text input in insert mode",
  })

  logging.info("PowerEmoji plugin configured")
end


return M
