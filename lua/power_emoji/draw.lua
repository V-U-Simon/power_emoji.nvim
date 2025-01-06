local M = {}
local logging = require("power_emoji.logging")

local cursor_namespace = vim.api.nvim_create_namespace("text_animation")

M.render_emoji = function(row, col, emoji)
  if row < 1 or col < 1 or row > vim.o.lines or col > vim.o.columns then
    logging.warn("Invalid cursor position for rendering emoji")
    return
  end

  vim.api.nvim_buf_set_extmark(0, cursor_namespace, row - 1, col - 1, {
    virt_text = { { emoji, "Normal" } },
    virt_text_pos = "overlay",
    hl_mode = "combine",
  })

  logging.debug(string.format("Emoji '%s' rendered at (%d, %d)", emoji, row, col))
end

M.clear = function()
  vim.api.nvim_buf_clear_namespace(0, cursor_namespace, 0, -1)
  logging.info("Cleared all rendered emojis")
end

return M
