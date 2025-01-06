local M = {}

-- General configuration -------------------------------------------------------

-- Enable animation in insert mode
M.enable_insert_animation = true

-- List of filetypes where the plugin is disabled
M.filetypes_disabled = { "help", "dashboard", "NvimTree" }

-- Delay before starting animation after cursor moves (ms)
M.animation_delay = 20

-- Duration of animation (ms)
M.animation_duration = 300

-- Emoji or symbols to use for animations
M.animation_symbols = { "✨", "🔥", "💫", "🌟" }

-- Maximum distance the emoji can travel (in characters)
M.max_distance = 5

-- Framerate for the animation (ms per frame)
M.framerate = 16

-- Logging level for debugging (vim.log.levels.INFO by default)
M.logging_level = vim.log.levels.INFO

return M
