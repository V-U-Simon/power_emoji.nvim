local config = require("my_emoji_effect.config")
local animation = require("my_emoji_effect.animation.init")

local M = {}

M.config = vim.deepcopy(config)
M.enabled = true -- Флаг состояния включения эффекта

-- Функция отображения эмодзи
function M.show_emoji()
  if not M.enabled then return end
  
  vim.schedule(function()
    if vim.fn.mode() ~= 'i' then
      return
    end

    animation.run(
      M.config.emoji,
      M.config.duration,
      M.config.steps,
      M.config.offset_x,
      M.config.offset_y,
      M.config.distance_factor,
      M.config.twist_factor
    )
  end)
end

-- Настраиваем автокоманды
function M.setup_autocmd()
  vim.api.nvim_create_autocmd("TextChangedI", {
    callback = M.show_emoji,
    group = vim.api.nvim_create_augroup("EmojiEffectFloatingGroup", { clear = true }),
  })
end

-- Включение эффекта
function M.enable()
  if not M.enabled then
    M.enabled = true
    M.setup_autocmd()
    print("Emoji Effect Enabled")
  end
end

-- Отключение эффекта
function M.disable()
  if M.enabled then
    M.enabled = false
    vim.api.nvim_clear_autocmds({ group = "EmojiEffectFloatingGroup" })
    print("Emoji Effect Disabled")
  end
end

-- Проверка состояния эффекта
function M.is_enabled()
  return M.enabled
end

-- Основная функция настройки
function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
  if M.enabled then
    M.setup_autocmd()
  end
end

return M
