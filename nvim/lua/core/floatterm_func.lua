local vim = vim

local M ={}
function M.baseConfig()
  vim.g.floaterm_gitcommit                 = 'floaterm'
  vim.g.floaterm_width                     = 0.9
  vim.g.floaterm_height                    = 0.8
  vim.g.floaterm_wintitle                  = 0
  vim.g.floaterm_autoclose                 = 1
  vim.g.floaterm_completeoptPreview        = 0
  vim.g.floaterm_keymap_toggle             = '<leader>cc'
end

return M
