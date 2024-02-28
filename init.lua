-- Automatically install lazy.nvim if it does not exist
local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
 vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('core')
require('lazy').setup('plugins')
require('lsp')
require('keymappings')

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd [[
         silent! colorscheme gruvbox
         hi Normal guibg=#0a0a0a
 ]]

 vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
