local M = {}
local animation = require("power_emoji.animation")
local logging = require("power_emoji.logging")

local function on_insert_enter()
  logging.debug("InsertEnter detected")
  animation.trigger()
end

local function on_insert_leave()
  logging.debug("InsertLeave detected")
  animation.stop()
end

M.listen = function()
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = on_insert_enter,
    desc = "Start animation on entering insert mode",
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = on_insert_leave,
    desc = "Stop animation on leaving insert mode",
  })

  logging.info("Event listeners registered")
end

M.unlisten = function()
  vim.api.nvim_clear_autocmds({ event = { "InsertEnter", "InsertLeave" } })
  logging.info("Event listeners unregistered")
end

return M
