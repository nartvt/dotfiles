
local home = os.getenv("HOME")
local vim = vim

local M ={}
function M.disableProviderSupport()
  -- disable language provider support (lua and vimscript plugins only)
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_python_provider = 0
  vim.g.loaded_python3_provider = 0
end

function M.unloadUnuseStuff()
  -- disable unused stuff
  vim.g.loaded = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_tutor_mode_plugin = 1
  vim.g.loaded_matchit = 1    -- use vim-matchup
  vim.g.loaded_matchparen = 1 -- use vim-matchup
end

function  M.baseSetting()
  -- Enable file type detection
  vim.cmd('filetype indent on')
  -- Enable smart indent
  vim.o.smartindent = true
  vim.wo.relativenumber                = true
  -- basic settings
  vim.cmd('filetype plugin on')
  vim.g.completeopt = { "menuone", "noinsert", "noselect" }
  vim.opt_global.shortmess:remove("F")
  vim.opt.encoding                         = "utf-8"
  vim.opt.backspace                        = "indent,eol,start" -- backspace works on every char in insert mode
  vim.opt.history                          = 100
  vim.opt.startofline                      = true
  vim.opt.clipboard                        = 'unnamedplus'
  vim.opt.textwidth                        = 73
  vim.opt.fileformats                      = 'unix'

  vim.opt.timeout                          = true
  vim.opt.timeoutlen                       = 300

  -- display
  vim.opt.showmatch                        = true -- show matching brackets
  vim.opt.scrolloff                        = 3 -- always show 3 rows from edge of the screen
  vim.opt.synmaxcol                        = 300 -- stop syntax highlight after x lines for performance
  vim.opt.laststatus                       = 2 -- always show status line
  vim.opt.list                             = false -- do not display white characters
  vim.opt.foldenable                       = false
  vim.opt.foldlevel                        = 4 -- limit folding to 4 levels
  vim.opt.foldmethod                       = 'syntax' -- use language syntax to generate folds
  vim.opt.wrap                             = false --do not wrap lines even if very long
  vim.opt.eol                              = false -- show if there's no eol char
  vim.opt.showbreak                        = '↪' -- character to show when line is broken
  vim.opt.termguicolors                    = true

  -- text format
  vim.opt.tabstop                          = 2
  vim.opt.shiftwidth                       = 2
  vim.opt.softtabstop                      = 2
  vim.opt.cindent                          = true
  vim.opt.autoindent                       = true
  vim.opt.smartindent                      = true
  vim.opt.expandtab                        = true -- expand tab to spaces
  vim.opt.smarttab                         = true
  vim.g.mapleader                          = " "

  -- search
  vim.opt.incsearch                        = true -- starts searching as soon as typing, without enter needed
  vim.opt.ignorecase                       = true -- ignore letter case when searching
  vim.opt.smartcase                        = true -- case insentive unless capitals used in search

-- sidebar
  vim.opt.number                           = true  -- line number on the left
  vim.opt.numberwidth                      = 3     -- always reserve 3 spaces for line number
  vim.opt.signcolumn                       = 'yes' -- keep 1 column for coc.vim  check
  vim.opt.modelines                        = 0
  vim.opt.showcmd                          = true  -- display command in bottom bar
end

function  M.backup()
  -- backup and undo
  vim.opt.backup                           = true
  vim.opt.swapfile                         = false
  vim.opt.backupdir                        = home .. '/.config/nvim/.backup/'
  vim.opt.directory                        = home .. '/.config/nvim/.swp/'
  vim.opt.undodir                          = home .. '/.config/nvim/.undo/'
  vim.opt.undofile                         = true
  vim.opt.undolevels                       = 1000
  vim.opt.undoreload                       = 10000
end

return M
