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
Plug 'dart-lang/dart-vim-plugin'

Plug 'natebosch/vim-lsc', {'tag': 'v0.4.0'}
Plug 'natebosch/vim-lsc-dart'

Plug 'neoclide/coc.nvim', {'branch': 'release'}                                                                                                                                                                  
Plug 'josa42/coc-go', {'branch': 'master'} 

Plug 'airblade/vim-gitgutter', {'branch': 'master'}
Plug 'tpope/vim-fugitive', {'branch': 'master'}

"--- tig blame
Plug 'crusoexia/vim-monokai'
Plug 'tveskag/nvim-blame-line'
" vim-plug
Plug 'iberianpig/tig-explorer.vim'
" vim-plug
Plug 'rbgrouleff/bclose.vim'
" NeoBundle
"NeoBundle 'rbgrouleff/bclose.vim'
" --- end of tig blame  

Plug 'kdheepak/lazygit.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'

Plug 'neovim/nvim-lspconfig'
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Markdown 
"Plug 'davidgranstrom/nvim-markdown-preview'
call plug#end()

" BASIC
let mapleader=" "
set completeopt-=preview
set autowrite
"set ignorecase
"set smartcase
set updatetime=50
set timeoutlen=500
set mmp=500
set number
set relativenumber

" Encoding                                                                                                                                                                                                                                                                           s
set encoding=utf-8                                                                                                                                                                                                                                                                    
set fileencoding=utf-8                  " The encoding written to file                                                                                                                                                                                                                
set fileencodings=utf-8                                                                                                                                                                                                                                                               
set fileformats=unix
" floaterm 
let g:floaterm_keymap_toggle = '<leader>tf'
let g:floaterm_gitcommit='floaterm'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_completeoptPreview=1
" gitgutter                                                                                                                                                                                                          
" un map all keys bindings of gitgutter then will map it again                                                                                                                                                       
let g:coc_config_home = '/Users/nartvt/.config/nvim'

let g:gitgutter_map_keys = 0
" gitgutter                                                                                                                                                                                                      
let g:gitgutter_preview_win_floating = 1
nmap ght <Plug>(GitGutterToggle)                                                                                                                                                                                 
nmap ghp <Plug>(GitGutterPreviewHunk)                                                                                                                                                                            
nmap ghu <Plug>(GitGutterUndoHunk)                                                                                                                                                                               
nmap ]c <Plug>(GitGutterNextHunk)                                                                                                                                                                                
nmap [c <Plug>(GitGutterPrevHunk)
" Lazy git 
nnoremap <silent> <leader>gg :LazyGit<CR>

" LSC
"let g:lsc_enable_autocomplete = v:true
"let g:lsc_server_commands = {'dart': 'dart_language_server'}
"let g:lsc_reference_highlights = v:false
"let g:lsc_trace_level          = 'on'
let g:go_def_mode = 'gopls'
let g:go_info_mode='gopls'

syntax on
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

set clipboard+=unnamedplus

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

" Terminal
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 1})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <leader>xx :call TermToggle(20)<CR>
"inoremap <leader>as <Esc>:call TermToggle(12)<CR>
"tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <leader>cx :<C-\><C-n> :q!<CR>

" generator json tag for go struct
nnoremap <silent><leader>fj :GoAddTags json<CR>

" Remember cursor position                                                                                                                                                                                           
augroup vimrc-remember-cursor-position                                                                                                                                                                               
autocmd!                                                                                                                                                                                                             
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif                                                                                                                    
augroup END
    
" DART
" let g:dart_format_on_save = 1
" let g:dart_style_guide = 0

" FLUTTER
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)


" FZF
let g:fzf_layout = { 'down': '100%'}

" COMMAND
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--smart-case --color-path="0;33"', {'options': '--delimiter : --nth 4..'}, <bang>0)

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
" view current open files
nnoremap <silent><leader>b :Buffers<CR>
" MAP
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-p> :FZF!<CR>
nmap <Space> <kDivide>
nmap <silent> <leader>m :History<CR>
nmap <leader>f :Ag<CR>
nmap <silent> <Space><Space> :noh<CR>
"nmap <leader>d :LSClientEnable<CR>:lopen<CR>
"nmap <leader>dd :LSClientDisable<CR>:lclose<CR>
nmap <silent><C-s> :w!<CR>
nmap <leader>e :q!<CR>

" Better window navigation ctrl+h,j,k,l instead of ctrl+w+h,j,k,l
nnoremap <C-h> <C-w>h                                                                                                                                                                                                                                                                   
nnoremap <C-j> <C-w>j                                                                                                                                                                                                                                                                   
nnoremap <C-k> <C-w>k                                                                                                                                                                                                                                                                   
nnoremap <C-l> <C-w>l 

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

nmap <silent><leader>tg :TigBlame<CR>
" MAP COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>on :syntax on<CR>
" Copy to clipboard
"nnoremap <silent> YY :%y+<CR>
"noremap y :*y
"nnoremap <silent> gd <Plug><cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gy <Plug><cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <Plug><cmd>lua vim.lsp.buf.references()<CR>
" MARKDOWN PREVIEWS
" END of markdown

" MAP LSP 

nmap <leader>so :so %<CR>
let g:gruvbox_contrast_dark = 'soft'

color gruvbox
"color monokai
set background=dark
"set termguicolors
