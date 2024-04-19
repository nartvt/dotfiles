local vim = vim

local M ={}
function M.baseConfig()
  local g = vim.g
  g.floaterm_gitcommit                 = 'floaterm'
  g.floaterm_width                     = 0.9
  g.floaterm_height                    = 0.8
  g.floaterm_wintitle                  = 0
  g.floaterm_autoclose                 = 1
  g.floaterm_completeoptPreview        = 0
  g.floaterm_keymap_toggle             = '<leader>cc'
end

return M
