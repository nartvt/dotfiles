local vim = vim

local M = {}
function M.golangHighlight()
  vim.g.go_highlight_structs               = 1
  vim.g.go_highlight_methods               = 1
  vim.g.go_highlight_functions             = 1
  vim.g.go_highlight_operators             = 1
  vim.g.go_highlight_build_constraints     = 1
  vim.g.go_highlight_function_calls        = 1
  vim.g.go_highlight_fields                = 1
  vim.g.go_highlight_variable_declarations = 0
  vim.g.go_highlight_variable_assignments  = 1
  vim.g.go_highlight_types                 = 1
  vim.g.go_def_mode                        = 'gopls'
  vim.g.go_info_mode                       = 'gopls'
end

function M.golangBuild()
  local go_fmt_command = vim.api.nvim_create_augroup('go-fmt-command', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  	pattern = '*.go',
  	group = go_fmt_command,
  	command = 'GoBuild',
  })
  vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  	pattern = '*.go',
  	group = go_fmt_command, -- equivalent to group=mygroup
  	command = 'set ft=go',
  })
end

return M
