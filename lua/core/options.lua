-------------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local home = os.getenv("HOME")
local g = vim.g
local opt = vim.opt
local opt_global = vim.opt_global
local api = vim.api


-- disable language provider support (lua and vimscript plugins only)
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python_provider = 0
g.loaded_python3_provider = 0

-- disable unused stuff
g.loaded = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_matchit = 1    -- use vim-matchup
g.loaded_matchparen = 1 -- use vim-matchup

-- basic settings
vim.cmd('filetype plugin on')
g.completeopt = { "menuone", "noinsert", "noselect" }
opt_global.shortmess:remove("F")
opt.encoding                         = "utf-8"
opt.backspace                        = "indent,eol,start" -- backspace works on every char in insert mode
opt.history                          = 100
opt.startofline                      = true
opt.clipboard                        = 'unnamedplus'
opt.textwidth                        = 73
opt.fileformats                      = 'unix'

-- wait time
-- opt.timeout = false
opt.timeout                          = true
opt.timeoutlen                       = 300

-- display
opt.showmatch                        = true -- show matching brackets
opt.scrolloff                        = 3 -- always show 3 rows from edge of the screen
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

-- sidebar
opt.number                           = true  -- line number on the left
opt.numberwidth                      = 3     -- always reserve 3 spaces for line number
opt.signcolumn                       = 'yes' -- keep 1 column for coc.vim  check
opt.modelines                        = 0
opt.showcmd                          = true  -- display command in bottom bar

-- search
opt.incsearch                        = true -- starts searching as soon as typing, without enter needed
opt.ignorecase                       = true -- ignore letter case when searching
opt.smartcase                        = true -- case insentive unless capitals used in search

-- backup and undo
opt.backup                           = true
opt.swapfile                         = false
opt.backupdir                        = home .. '/.config/nvim/.backup/'
opt.directory                        = home .. '/.config/nvim/.swp/'
opt.undodir                          = home .. '/.config/nvim/.undo/'
opt.undofile                         = true
opt.undolevels                       = 1000
opt.undoreload                       = 10000

-- text format
opt.tabstop                          = 2
opt.shiftwidth                       = 2
opt.softtabstop                      = 2
opt.cindent                          = true
opt.autoindent                       = true
opt.smartindent                      = true
opt.expandtab                        = true -- expand tab to spaces
opt.smarttab                         = true
g.mapleader                          = " "

g.go_highlight_structs               = 1
g.go_highlight_methods               = 1
g.go_highlight_functions             = 1
g.go_highlight_operators             = 1
g.go_highlight_build_constraints     = 1
g.go_highlight_function_calls        = 1
g.go_highlight_fields                = 1
g.go_highlight_variable_declarations = 0
g.go_highlight_variable_assignments  = 1
g.go_highlight_types                 = 1
g.go_def_mode                        = 'gopls'
g.go_info_mode                       = 'gopls'

g.floaterm_gitcommit                 = 'floaterm'
g.floaterm_width                     = 0.9
g.floaterm_height                    = 0.8
g.floaterm_wintitle                  = 0
g.floaterm_autoclose                 = 1
g.floaterm_completeoptPreview        = 0
g.floaterm_keymap_toggle             = '<leader>cc'
vim.wo.relativenumber                = true

g.fzf_layout                         = { down = '100%', up = '100%' }
g.NERDTreeShowHidden                 = 1
api.nvim_command(
	'command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, "--smart-case --color-path=\\"0;33\\"", {\'options\': "--delimiter : --nth 4.."}, <bang>0)')


local go_fmt_command = vim.api.nvim_create_augroup('go-fmt-command', { clear = true })
api.nvim_create_autocmd({ 'BufWritePost' }, {
	pattern = '*.go',
	group = go_fmt_command,
	command = 'GoBuild',
})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	pattern = '*.go',
	group = go_fmt_command, -- equivalent to group=mygroup
	command = 'set ft=go',
})


-- use ripgrep if exists
if (vim.fn.executable('rg') ~= 0) then
	vim.env.FZF_DEFAULT_COMMAND =
	'rg --hidden --files --glob="!.git/*" --glob="!*.class" --glob="!venv/*" --glob="!coverage/*" --glob="!node_modules/*" --glob="!target/*" --glob="!__pycache__/*" --glob="!dist/*" --glob="!build/*" --glob="!*.DS_Store"'
	vim.api.nvim_set_option('grepprg', 'rg --vimgrep --smart-case --follow')
elseif (vim.fn.executable('ag') ~= 0) then
	vim.env.FZF_DEFAULT_COMMAND =
	'ag --hidden --ignore .git --ignore venv/ --ignore coverage/ --ignore node_modules/ --ignore target/  --ignore __pycache__/ --ignore dist/ --ignore build/ --ignore .DS_Store  --ignore .class -g ""'
	vim.api.nvim_set_option('grepprg', 'ag')
else
	-- else fallback to find
	vim.env.FZF_DEFAULT_COMMAND =
	[[find * -path '*/\.*' -prune -o -path 'venv/**' -prune -o -path  'coverage/**' -prune -o -path 'node_modules/**' -prune -o -path '__pycache__/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null]]
end

-- use fd if exists
-- if (vim.fn.executable('fd') ~= 0) then
-- 	vim.env.FZF_DEFAULT_COMMAND =
-- 	'fd --type f --follow --hidden --exclude=".git/*" --exclude="venv/*" --exclude="coverage/*" --exclude="node_modules/*" --exclude="target/*" --exclude="__pycache__/*" --exclude="dist/*" --exclude="build/*" --exclude="*.DS_Store --exclude="*.class"'
-- end

-- Enable file type detection
vim.cmd('filetype indent on')

-- Enable smart indent
vim.o.smartindent = true
