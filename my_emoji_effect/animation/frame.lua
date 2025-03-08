-- file: my_emoji_effect/animation/frame.lua
local M = {}

-- Глобальный счётчик окон (только в рамках этого модуля)
local frame_counter = 0

--- Создаёт буфер и плавающее окно с эмодзи
---@param emoji string  Эмодзи
---@param offset_x number
---@param offset_y number
---@return number win_id
---@return number bufnr
function M.create(emoji, offset_x, offset_y)
  -- Увеличиваем счётчик
  frame_counter = frame_counter + 1

  -- Например, каждое новое окно будем сдвигать на +2 строки и +2 колонки
  -- относительно базовых offset_x, offset_y
  local my_row = offset_y + (frame_counter * 2)
  local my_col = offset_x + (frame_counter * 2)

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { emoji })

  local win_id = vim.api.nvim_open_win(bufnr, false, {
    relative = "cursor",
    row = my_row,
    col = my_col,
    width = 3,
    height = 3,
    style = "minimal",
    focusable = false,
    border = nil,
  })
  -- При первом открытии делаем окно непрозрачным
  vim.api.nvim_win_set_option(win_id, "winblend", 0)

  return win_id, bufnr
end

--- Обновляет позицию и winblend окна
function M.update(win_id, row, col, blend)
  vim.api.nvim_win_set_config(win_id, {
    relative = "cursor",
    row = row,
    col = col,
    width = 2,
    height = 1,
    style = "minimal",
    focusable = false,
    border = nil,
  })
  vim.api.nvim_win_set_option(win_id, "winblend", blend)
end

--- Закрывает окно через заданную задержку (мс)
function M.close_after(win_id, delay)
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win_id) then
      vim.api.nvim_win_close(win_id, true)
    end
  end, delay)
end

return M
