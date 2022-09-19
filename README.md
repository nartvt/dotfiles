install 

1. brew install neovim
2. brew install lazygit
3. brew install fzf
4. brew install the_silver_searcher 
5. install nodejs >= 14.0 and install yarn: npm install yarn -g
6. Clone this repo, copy all file at folder `dotfile` to `$HOME/.config/nvim/`
7. Open `init.vim` at `$HOME/.config/nvim/init.vim`, install Plugin by command: `:PlugInstall`
8. Install coc by yarn, go to `$HOME/.vim/plugged/coc.nvim` and type at command:  `yarn install` for install package of coc-settings
9. Install coc-setting dependency
+ Open: `$HOME/.config/nvim/init.vim` by nvim and  run bellow command:  `:CocInstall coc-json coc-tsserver`
10. Install `goimports` for auto format go source and import on thefly   
+ Open terminal and run: `go install golang.org/x/tools/cmd/goimports@latest`
+ OR open `init.vim` and run `:GoInstallBinaries`
