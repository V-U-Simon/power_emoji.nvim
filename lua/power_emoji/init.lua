-- local animation = require("power_emoji.animation")
-- local events = require("power_emoji.events")
-- local config = require("power_emoji.config")
local M = {}

local enabled = false

local function initialize()
  -- events.listen()
  -- animation.start()
  print("[PowerEmoji] Module loaded and initialized!")
end

-- local metatable = {
--   __index = function(table, key)
--     if key == "enabled" then
--       return enabled
--     elseif config[key] ~= nil then
--       return config[key]
--     end
--     return nil
--   end,

--   __newindex = function(table, key, value)
--     if key == "enabled" then
--       enabled = value
--       if enabled then
--         initialize()
--       else
--         events.unlisten()
--         animation.stop()
--       end
--     elseif config[key] ~= nil then
--       config[key] = value
--     else
--       rawset(table, key, value)
--     end
--   end,
-- }

-- M.setup = function(opts)
--   opts = opts or {}
--   if opts.enabled == nil then opts.enabled = true end

--   for key, value in pairs(opts) do
--     M[key] = value
--   end

--   vim.api.nvim_create_user_command("TextAnimationToggle", M.toggle, {})
-- end

-- M.toggle = function()
--   M.enabled = not M.enabled
-- end

-- setmetatable(M, metatable)
return M
