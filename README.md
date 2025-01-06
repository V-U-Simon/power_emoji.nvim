:TextAnimationToggle для включения и выключения анимации.

for LazyVim

```lua
return {
  {
    "V-U-Simon/power_emoji.nvim",
    event = "InsertEnter",
    config = function()
      require("power_emoji").setup({
        enabled = true,
        animation_symbols = { "✨", "🔥", "💫", "🌟" },
        animation_delay = 20,
        animation_duration = 300,
        framerate = 16,
        max_distance = 5,
        filetypes_disabled = { "help", "dashboard", "NvimTree" },
        logging_level = vim.log.levels.INFO,
      })
    end,
  },
}
```