-------------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------


local util = require("core.util")
util.baseSetting()
util.disableProviderSupport()
util.backup()
util.unloadUnuseStuff()
util.codeiumConfig()

local term = require("core.floatterm_func")
term.baseConfig()

local golang =  require("core.go_func")
golang.golangHighlight()
golang.golangBuild()

local java =  require("core.java_func")
java.JavaHighlight()
java.JavaBuild()

local f = require("core.fzf_func")
f.config()
-- f.searchFzfCommand()
-- f.findFileFromCurrentDirFzf()


