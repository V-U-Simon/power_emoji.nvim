local M = {}

-- Получение позиции курсора на экране
M.get_cursor_position = function()
  local window_id = vim.api.nvim_get_current_win()
  local window_info = vim.fn.getwininfo(window_id)[1]

  if not window_info then
    return nil, nil -- Вернём nil, если окно не определено
  end

  local row = vim.fn.screenrow()
  local col = vim.fn.screencol()

  -- Корректируем позицию для окон с отступами
  if window_info.winrow and window_info.wincol then
    row = row + window_info.winrow - 1
    col = col + window_info.wincol - 1
  end

  -- Убеждаемся, что координаты находятся в допустимом диапазоне
  if col < 1 or row < 1 or col > vim.o.columns or row > vim.o.lines then
    return nil, nil
  end

  return row, col
end

return M
