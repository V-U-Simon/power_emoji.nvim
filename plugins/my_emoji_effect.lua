return {
    {
      name = "my_emoji_effect",
      -- Путь к вашей папке с плагином
      dir = vim.fn.stdpath("config") .. "/lua/my_emoji_effect",
  
      -- Когда загружать
      event = "InsertEnter",
  
      -- Конфигурация
      config = function()
        require("my_emoji_effect").setup({
          -- emoji = "⚡",       -- Эмодзи
          -- duration = 900,     -- Длительность анимации (мс)
          -- steps = 300,         -- Количество шагов анимации
          -- offset_x = 0,       -- Начальное горизонтальное смещение
          -- offset_y = 0,       -- Начальное вертикальное смещение
          -- увеличение дистанции улучшает плавность
          -- distance_factor = 2.0,  -- множитель дистанции
          -- twist_factor = 0.07,     -- множитель "закрутки"
        })
      end,
    },
  }
