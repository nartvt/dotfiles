-- Automatically install lazy.nvim if it does not exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyRepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyRepo, lazypath})
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo ({
        {"Failed to clone lazy.nvim: \n", "ErrMsg"},
        {out, "WarningMsg"},
        {"\nPress any key to exit..."},
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('core')
require("lazy").setup({
  spec = {
    {import = 'plugins'},
  },
  install = {colorscheme = 'gruvbox'},
  checker = {enable = true}
})
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

