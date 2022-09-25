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

11. Error if present at vim open file 
```
[coc.nvim]: dyld[11689]: Library not loaded: '/opt/homebrew/opt/icu4c/lib/libicudata.70.dylib'
  Referenced from: '/opt/homebrew/Cellar/boost/1.79.0_1/lib/libboost_regex-mt.dylib'
  Reason: tried: '/opt/homebrew/opt/icu4c/lib/libicudata.70.dylib' (no such file), '/usr/local/lib/libicudata.70.dylib' (no such file), '/usr/lib/libicudata.70.dylib' (no such file), '/opt/homebrew/Cellar/icu4c/71.1/lib/libicudata.70.dylib' (no such fil
e), '/usr/local/lib/libicudata.70.dylib' (no such file), '/usr/lib/libicudata.70.dylib' (no such file)
Watchman:  /opt/homebrew/bin/watchman --no-pretty get-sockname returned with exit code=null, signal=SIGABRT, stderr= dyld[11689]: Library not loaded: '/opt/homebrew/opt/icu4c/lib/libicudata.70.dylib'
  Referenced from: '/opt/homebrew/Cellar/boost/1.79.0_1/lib/libboost_regex-mt.dylib'
  Reason: tried: '/opt/homebrew/opt/icu4c/lib/libicudata.70.dylib' (no such file), '/usr/local/lib/libicudata.70.dylib' (no such file), '/usr/lib/libicudata.70.dylib' (no such file), '/opt/homebrew/Cellar/icu4c/71.1/lib/libicudata.70.dylib' (no such fil
e), '/usr/local/lib/libicudata.70.dylib' (no such file), '/usr/lib/libicudata.70.dylib' (no such file)
Uncaught exception: /opt/homebrew/bin/watchman --no-pretty get-sockname returned with exit code=null, signal=SIGABRT, stderr= dyld[11689]: Library not loaded: '/opt/homebrew/opt/icu4c/lib/libicudata.70.dylib'
  Referenced from: '/opt/homebrew/Cellar/boost/1.79.0_1/lib/libboost_regex-mt.dylib'
  Reason: tried: '/opt/homebrew/opt/icu4c/lib/libicudata.70.dylib' (no such file), '/usr/local/lib/libicudata.70.dylib' (no such file), '/usr/lib/libicudata.70.dylib' (no such file), '/opt/homebrew/Cellar/icu4c/71.1/lib/libicudata.70.dylib' (no such fil
e), '/usr/local/lib/libicudata.70.dylib' (no such file), '/usr/lib/libicudata.70.dylib' (no such file)
```

How to resolved: add to .bashrc OR .zshrc as bellow

```
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig"
```
