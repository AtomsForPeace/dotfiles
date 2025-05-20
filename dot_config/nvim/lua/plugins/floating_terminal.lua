-- ~/.config/nvim/lua/plugins/floating_terminal.lua

return {
  dir = vim.fn.stdpath('config') .. '/lua/adam/floating_terminal',
  name = 'adam_floating_terminal_plugin', -- Give it a unique name for lazy.nvim
  lazy = true, -- Lazy load this plugin. It will be loaded when you press '<C-space>'.
  keys = {
    -- Keymap for normal mode (n) - this will OPEN it
    -- This is the only keymap defined in the lazy.nvim spec now.
    { '<C-space>', function() require('adam.floating_terminal').toggle_terminal() end, desc = "Toggle Floating Terminal" },
  },
  -- The 'config' function is removed because terminal-mode keymaps are now set in init.lua.
}
