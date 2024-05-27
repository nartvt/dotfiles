local vim = vim
local util = require("me.util")
local remap = util.remap
--local home = os.getenv('HOME')
local M = {}

local on_attach = function(_, bufnr)
    	-- Mappings.
  	-- See `:help vim.lsp.*` for documentation on any of the below functions
  	local bufopts = { noremap = true, silent = true, buffer = bufnr }
  	remap('n', 'gf', vim.lsp.buf.declaration, bufopts, "Go to declaration")
  	remap('n', 'gd', vim.lsp.buf.definition, bufopts, "Go to definition")
  	remap('n', 'gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
  	remap('n', 'gr', vim.lsp.buf.references, bufopts, "Go to references")
  	remap('n', 'hv', vim.lsp.buf.hover, bufopts, "Hover text")
  	remap('n', '<C-l>', vim.lsp.diagnostic.show_line_diagnostics(), bufopts, "show line error")
  	remap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
  	remap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  	remap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  	remap('n', '<space>wl', function()
  		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  	end, bufopts, "List workspace folders")
  	remap('n', '<space>rk', vim.lsp.buf.rename, bufopts, "Rename")
  	remap('n', '<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
  	vim.keymap.set('v', "<C-i>", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
  		{ noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })
  	remap('n', '<C-r>', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
end

M.on_attach = on_attach

return M
