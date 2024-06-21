
local home = os.getenv("HOME")
local vim = vim

local M ={}
function M.disableProviderSupport()
  -- disable language provider support (lua and vimscript plugins only)
  local g = vim.g
  g.loaded_perl_provider = 0
  g.loaded_ruby_provider = 0
  g.loaded_node_provider = 0
  g.loaded_python_provider = 0
  g.loaded_python3_provider = 0
end

function M.unloadUnuseStuff()
  -- disable unused stuff
  local g = vim.g
  g.loaded = 1
  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1
  g.loaded_2html_plugin = 1
  g.loaded_tutor_mode_plugin = 1
  g.loaded_matchit = 1    -- use vim-matchup
  g.loaded_matchparen = 1 -- use vim-matchup
end

function  M.baseSetting()
  -- Enable file type detection
  vim.cmd('filetype indent on')
  -- Enable smart indent
  vim.o.smartindent = true
  vim.wo.relativenumber                = true
  -- basic settings
  vim.cmd('filetype plugin on')
  local opt = vim.opt
  vim.g.completeopt = { "menuone", "noinsert", "noselect" }
  vim.opt_global.shortmess:remove("F")
  opt.encoding                         = "utf-8"
  opt.backspace                        = "indent,eol,start" -- backspace works on every char in insert mode
  opt.history                          = 100
  opt.startofline                      = true
  opt.clipboard                        = 'unnamedplus'
  opt.textwidth                        = 73
  opt.fileformats                      = 'unix'

  vim.opt.timeout                          = true
  vim.opt.timeoutlen                       = 300

  -- display
  opt.showmatch                        = true -- show matching brackets
  opt.synmaxcol                        = 300 -- stop syntax highlight after x lines for performance
  opt.laststatus                       = 2 -- always show status line
  opt.list                             = false -- do not display white characters
  opt.foldenable                       = false
  opt.foldlevel                        = 4 -- limit folding to 4 levels
  opt.foldmethod                       = 'syntax' -- use language syntax to generate folds
  opt.wrap                             = false --do not wrap lines even if very long
  opt.eol                              = false -- show if there's no eol char
  opt.showbreak                        = '↪' -- character to show when line is broken
  opt.termguicolors                    = true

  -- text format
  opt.tabstop                          = 2
  opt.shiftwidth                       = 2
  opt.softtabstop                      = 2
  opt.cindent                          = true
  opt.autoindent                       = true
  opt.smartindent                      = true
  opt.expandtab                        = true -- expand tab to spaces
  opt.smarttab                         = true
  vim.g.mapleader                          = " "

  -- search
  opt.incsearch                        = true -- starts searching as soon as typing, without enter needed
  opt.ignorecase                       = true -- ignore letter case when searching
  opt.smartcase                        = true -- case insentive unless capitals used in search

-- sidebar
  opt.number                           = true  -- line number on the left
  opt.numberwidth                      = 3     -- always reserve 3 spaces for line number
  opt.signcolumn                       = 'yes' -- keep 1 column for coc.vim  check
  opt.modelines                        = 0
  opt.showcmd                          = true  -- display command in bottom bar
  opt.scrolloff                        = 15
end

function  M.backup()
  -- backup and undo
  local opt = vim.opt
  opt.backup                           = true
  opt.swapfile                         = false
  opt.backupdir                        = home .. '/.config/nvim/.backup/'
  opt.directory                        = home .. '/.config/nvim/.swp/'
  opt.undodir                          = home .. '/.config/nvim/.undo/'
  opt.undofile                         = true
  opt.undolevels                       = 1000
  opt.undoreload                       = 10000
end

function M.codeiumConfig()
  local g = vim.g
  g.codeium_auth_token="eyJhbGciOiJSUzI1NiIsImtpZCI6IjMzMDUxMThiZTBmNTZkYzA4NGE0NmExN2RiNzU1NjVkNzY4YmE2ZmUiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiVHJhbiBWYW4gVGFpIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xNZF9iMXBEZVNTRFVWSDA1Yl9QVlg4aXJoTGtuWk5rWWQ3aEhxRUxnPXM5Ni1jIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2V4YTItZmIxNzAiLCJhdWQiOiJleGEyLWZiMTcwIiwiYXV0aF90aW1lIjoxNzExMjczNDc1LCJ1c2VyX2lkIjoicElmenZRbUlwVFMxSFJsdXBLWGNNU1ExQk1ZMiIsInN1YiI6InBJZnp2UW1JcFRTMUhSbHVwS1hjTVNRMUJNWTIiLCJpYXQiOjE3MTc2NDQ4NzQsImV4cCI6MTcxNzY0ODQ3NCwiZW1haWwiOiJ0cmFudmFudGFpMDAxMUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwNzY5MDExODA5MjAxNTM5OTA3NiJdLCJlbWFpbCI6WyJ0cmFudmFudGFpMDAxMUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJnb29nbGUuY29tIn19.TG2_GAyLj_uxWbpA4bQFygOLDH-dY4WbBOONAHdYFgYtZFXZYn_7dR1FsrXWhLrgE0NPv6g3bTHCxRCFIfHyuXTmAOIstpozve5mDbKpkKJFFqU5stTIjHpmcxZU8YuzF75TI73QHlgZyGjVP8kSB4vy9I05lcG34zG4dpL7cr3LMq1PvHD9jLv6H8pF1evvux3kjO8SQnLlnXYcanC7u_M3eUMdv1N3WFLbrRdyWrB9QpUrFvpEEi3hUAf7kgS8vbQNqOIDGejN3-vccuDmON92yqSmveqtuqwQ9dh_aXnKXCa0lX8SHlqJol9lBBxkzHGenVFX5Pek3xxA4fqkXg"
  g.codeium_enabled = true
  g.codeium_render = true
  g.codeium_workspace_root_hints = {'.bzr','.git','.hg','.svn','_FOSSIL_','package.json','.sh'}
 -- g.codeium_filetypes = {"go","java"}
end

return M
