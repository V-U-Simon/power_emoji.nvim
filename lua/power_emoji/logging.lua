local M = {}

local level_names = {
  [vim.log.levels.TRACE] = "TRACE",
  [vim.log.levels.DEBUG] = "DEBUG",
  [vim.log.levels.INFO] = "INFO",
  [vim.log.levels.WARN] = "WARNING",
  [vim.log.levels.ERROR] = "ERROR",
}

local function log(message, level)
  local logging_level = require("power_emoji.config").logging_level

  if logging_level <= level then
    vim.notify("[TextAnimation][" .. level_names[level] .. "] " .. message, level)
  end
end

M.trace = function(message)
  log(message, vim.log.levels.TRACE)
end

M.debug = function(message)
  log(message, vim.log.levels.DEBUG)
end

M.info = function(message)
  log(message, vim.log.levels.INFO)
end

M.warn = function(message)
  log(message, vim.log.levels.WARN)
end

M.error = function(message)
  log(message, vim.log.levels.ERROR)
end

return M