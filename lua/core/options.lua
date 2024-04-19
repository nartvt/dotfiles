-------------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local f = require("core.fzf_func")
local golang =  require("core.go_func")
local util = require("core.util")
local term = require("core.floatterm_func")

util.baseSetting()
util.disableProviderSupport()
util.backup()
util.unloadUnuseStuff()
util.codeiumConfig()

term.baseConfig()

golang.golangHighlight()
golang.golangBuild()

f.config()
f.searchFzfCommand()
f.findFileFromCurrentDirFzf()


