" PLUGIN
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'fatih/gomodifytags', {'branch':'main'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'scrooloose/nerdTree'
Plug 'sainnhe/gruvbox-material'
Plug 'arcticicestudio/nord-vim'
Plug 'gruvbox-community/gruvbox'
"Plug 'morhetz/gruvbox'
"Plug 'dart-lang/dart-vim-plugin'

Plug 'natebosch/vim-lsc', {'tag': 'v0.4.0'}
"Plug 'natebosch/vim-lsc-dart'

Plug 'pechorin/any-jump.vim'
Plug 'neoclide/coc.nvim', {'branch': 'master'}
Plug 'josa42/coc-go', {'branch': 'master'} 

Plug 'airblade/vim-gitgutter', {'branch': 'master'}
Plug 'tpope/vim-fugitive', {'branch': 'master'}

"--- tig blame
Plug 'tveskag/nvim-blame-line'
" vim-plug
Plug 'iberianpig/tig-explorer.vim'
" vim-plug
Plug 'rbgrouleff/bclose.vim'
" NeoBundle
" --- end of tig blame  

Plug 'kdheepak/lazygit.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'

" Plug 'neovim/nvim-lspconfig'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Markdown 
"Plug 'davidgranstrom/nvim-markdown-preview'

" Plug 'OmniSharp/omnisharp-vim'
call plug#end()

" BASIC
let mapleader=" "
set completeopt-=preview
set autowrite
set ignorecase
set smartcase
set updatetime=50
set timeoutlen=500
set mmp=500
set number
set relativenumber

" Encoding                                                                                                                                                                                                                                                                           s
set encoding=utf-8                                                                                                                                                                                                                                                                    
set fileencoding=utf-8                  " The encoding written to file                                                                                                                                                                                                                
set fileformats=unix
set mmp=500000

" nerdTree resize
nnoremap <silent><leader>u :vertical resize +10<CR>
nnoremap <silent><leader>d :vertical resize -10<CR>

" MAP TIG BLAME
let g:tig_explorer_keymap_edit_e  = 'e'
let g:tig_explorer_keymap_edit    = '<C-o>'
let g:tig_explorer_keymap_tabedit = '<C-t>'
let g:tig_explorer_keymap_split   = '<C-s>'
let g:tig_explorer_keymap_vsplit  = '<C-v>'

let g:tig_explorer_keymap_commit_edit    = '<ESC>o'
let g:tig_explorer_keymap_commit_tabedit = '<ESC>t'
let g:tig_explorer_keymap_commit_split   = '<ESC>s'
let g:tig_explorer_keymap_commit_vsplit  = '<ESC>v'

nmap <leader>r :NERDTreeFocus<cr>R<c-w><c-p>

set clipboard+=unnamedplus

" floaterm 
let g:floaterm_keymap_toggle = '<leader>tf'
let g:floaterm_keymap_new = '<leader>fo'
let g:floaterm_keymap_prev = '<leader>fp'
let g:floaterm_keymap_next = '<leader>fn'
let g:floaterm_keymap_kill = '<leader>fk'

let g:floaterm_gitcommit='floaterm'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_completeoptPreview=1

" MAP ANY JUMP 
" Show line numbers in search rusults
let g:any_jump_list_numbers = 0

" Auto search references
let g:any_jump_references_enabled = 1

" Auto group results by filename
let g:any_jump_grouping_enabled = 1

" Amount of preview lines for each search result
let g:any_jump_preview_lines_count = 5

" Max search results, other results can be opened via [a]
let g:any_jump_max_search_results = 20

" Prefered search engine: rg or ag
let g:any_jump_search_prefered_engine = 'rg'


" Search results list styles:
" - 'filename_first'
" - 'filename_last'
let g:any_jump_results_ui_style = 'filename_first'

" Any-jump window size & position options
let g:any_jump_window_width_ratio  = 0.6
let g:any_jump_window_height_ratio = 0.6
let g:any_jump_window_top_offset   = 4

" Customize any-jump colors with extending default color scheme:
" let g:any_jump_colors = { "help": "Comment" }

" Or override all default colors
let g:any_jump_colors = {
      \"plain_text":         "Comment",
      \"preview":            "Comment",
      \"preview_keyword":    "Operator",
      \"heading_text":       "Function",
      \"heading_keyword":    "Identifier",
      \"group_text":         "Comment",
      \"group_name":         "Function",
      \"more_button":        "Operator",
      \"more_explain":       "Comment",
      \"result_line_number": "Comment",
      \"result_text":        "Statement",
      \"result_path":        "String",
      \"help":               "Comment"
      \}

" Disable default any-jump keybindings (default: 0)
let g:any_jump_disable_default_keybindings = 1

" Remove comments line from search results (default: 1)
let g:any_jump_remove_comments_from_results = 1

" Custom ignore files
" default is: ['*.tmp', '*.temp']
let g:any_jump_ignored_files = ['*.tmp', '*.temp']

" Search references only for current file type
" (default: false, so will find keyword in all filetypes)
let g:any_jump_references_only_for_current_filetype = 1

" Disable search engine ignore vcs untracked files
" (default: false, search engine will ignore vcs untracked files)
let g:any_jump_disable_vcs_ignore = 0

" gitgutter                                                                                                                                                                                                          
" un map all keys bindings of gitgutter then will map it again                                                                                                                                                       

let g:coc_config_home = '/Users/nartvt/.config/nvim'

let g:gitgutter_map_keys = 0
" gitgutter                                                                                                                                                                                                      
let g:gitgutter_preview_win_floating = 1
nnoremap ght <Plug>(GitGutterToggle)                                                                                                                                                                                 
nnoremap ghp <Plug>(GitGutterPreviewHunk)                                                                                                                                                                            
nnoremap ghu <Plug>(GitGutterUndoHunk)                                                                                                                                                                               
nnoremap ]c <Plug>(GitGutterNextHunk)                                                                                                                                                                                
nnoremap [c <Plug>(GitGutterPrevHunk)
" Lazy git 
nnoremap <silent> <leader>gg :LazyGit<CR>

" LSC
"let g:lsc_enable_autocomplete = v:true
"let g:lsc_server_commands = {'dart': 'dart_language_server'}
"let g:lsc_reference_highlights = v:false
"let g:lsc_trace_level          = 'on'
let g:go_def_mode = 'gopls'
let g:go_info_mode='gopls'

syntax enable
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" 
let g:go_highlight_function_calls = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 0 
let g:go_highlight_variable_assignments = 1
let g:go_highlight_types = 1


" GOLANG
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:go_def_mode = "godef"
if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  echo "writtern file"
  autocmd BufWritePost *.go :GoBuild
endif
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePost *.go :syntax on
autocmd BufWritePost *.go :set ft=go


" generator json tag for go struct
nnoremap <silent><leader>fj :GoAddTags json<CR>

" Remember cursor position                                                                                                                                                                                           
augroup vimrc-remember-cursor-position                                                                                                                                                                               
autocmd!                                                                                                                                                                                                             
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif                                                                                                                    
augroup END
    

" FZF

" open full screen
" let g:fzf_layout = { 'down': '100%', 'up': '100%'}

" COMMAND
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--smart-case --color-path="0;33"', {'options': '--delimiter : --nth 4..'}, <bang>0)
" verbose imap <tab>
" inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
" new coc config 0.0.82
" TAB confirm auto config
inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"
" ENTER for confirm auto complete
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"
" view current open files
nnoremap <silent><leader>b :Buffers<CR>
" MAP
nnoremap <silent><C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :FZF!<CR>
nnoremap <silent><C-f> :NERDTreeFind<CR>
nmap <Space> <kDivide>
nnoremap <silent> <leader>m :History<CR>
nnoremap  <leader>f :Ag<CR>
nnoremap <silent> <Space><Space> :noh<CR>
"nmap <leader>d :LSClientEnable<CR>:lopen<CR>
"nmap <leader>dd :LSClientDisable<CR>:lclose<CR>
nnoremap <silent><C-s> :w!<CR>
nnoremap <silent><leader>e :q!<CR>

" Better window navigation ctrl+h,j,k,l instead of ctrl+w+h,j,k,l
nnoremap <C-h> <C-w>h                                                                                                                                                                                                                                                                   
nnoremap <C-j> <C-w>j                                                                                                                                                                                                                                                                   
nnoremap <C-k> <C-w>k                                                                                                                                                                                                                                                                   
nnoremap <C-l> <C-w>l 

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

nmap <silent><leader>tg :TigBlame<CR>
" MAP COC
" " Normal mode: Jump to definition under cursor
nnoremap <silent><leader>j :AnyJump<CR>
nnoremap <silent>gd :AnyJump<CR>

" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
xnoremap <silent>gd :AnyJumpVisual<CR>

" Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>

" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>

" Copy to clipboard
"nnoremap <silent> YY :%y+<CR>
"noremap y :*y
"nnoremap <silent> gd <Plug><cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gy <Plug><cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <Plug><cmd>lua vim.lsp.buf.references()<CR>
" MARKDOWN PREVIEWS
" END of markdown

" MAP LSP 

nmap <silent><leader>so :so %<CR>
let g:gruvbox_contrast_dark = 'soft'

color gruvbox
"color monokai
set background=dark
"set termguicolors
"
