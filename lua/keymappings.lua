local remap = require("me.util").remap
-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local vim = vim
local bufopts = { silent = true, noremap = true }
-- local bufopts = require("lsp.common").bufopts

-- disable search highlighting by pressing enter
remap("n", "<cr>", "<cmd>:nohlsearch<cr><cr>")
remap("n", "<leader>b", "<cmd>:FineCmdline<cr>")

-- tab management
remap("n", "<C-Insert>", "<cmd>:tabnew<cr>", bufopts, "New tab")
remap("n", "<C-Delete>", "<cmd>:tabclose<cr>", bufopts, "Close tab")
remap("i", "<C-Insert>", "<cmd>:tabnew<cr>", bufopts, "New tab")
remap("i", "<C-Delete>", "<cmd>:tabclose<cr>", bufopts, "Close tab")

-- custom
remap("n", "<C-s>", "<cmd>:w!<cr>", bufopts, "Save File")
remap("n", "<C-q>", "<cmd>:q!<cr>", bufopts, "Quit File")
remap("n", "<leader><leader>", "<cmd>:noh<cr>", bufopts, "No highlight")
remap("n", "<leader>tg", "<cmd>:TigBlame<cr>", bufopts, "Git blame")
remap("n", "<C-f>", "<cmd>:NERDTreeFind<cr>", bufopts, "Current file location")
remap("n", "<C-n>", "<cmd>:NERDTreeToggle<cr>", bufopts, "Open left pannel")
remap("n", "<leader>m", "<cmd>:History<cr>", bufopts, "History open recent files")
-- remap("n", "<leader>m", "<cmd>:Telescope file_history history <cr>", bufopts, "History open recent files")
remap("n", "<C-h>", "<C-w>h", bufopts, "Jump to left")
remap("n", "<C-j>", "<C-w>j", bufopts, "Jump to bottom")
remap("n", "<C-k>", "<C-w>k", bufopts, "Jump to top")
remap("n", "<C-l>", "<C-w>l", bufopts, "Jump to right")
remap("n", "<C-g>", "<cmd>:vsplit<cr>", bufopts, "vertical split")
remap("n","<C-e>", "<cmd>:lua vim.diagnostic.open_float()<cr>",bufopts,"load error multiline")
vim.g.go_addtags_transform = 'snakecase' -- snakecase, camelcase
remap("n", "<leader>fj", "<cmd>:GoAddTags json,omitempty<Cr>", bufopts, "generation json tag")

-- telescope
-- remap("n", "<C-p>", "<cmd>:FZF!<cr>", bufopts, "Find file from current folfer")
remap("n", "<C-a>", "<cmd>Telescope find_files<cr>", bufopts, "Find file")
remap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", bufopts, "Grep")
remap("n", "<leader>h", "<cmd>Telescope git_stash<cr>", bufopts, "Git Stash History")
remap("n", "<leader>bf", "<cmd>Telescope buffers<cr>", bufopts, "Find buffer")
remap("n", "<leader>fm", "<cmd>Telescope marks<cr>", bufopts, "Find mark")
remap("n", "<C-x>"     , "<cmd>Telescope lsp_references<cr>", bufopts, "Find references in current folder (LSP)")
remap("n", "<C-z>"     , "<cmd>Telescope lsp_document_symbols<cr>", bufopts, "Find symbols method in a current file (LSP)")
remap("n", "<C-i>"     , "<cmd>Telescope lsp_incoming_calls<cr>", bufopts, "Find incoming calls in current file(LSP)")
remap("n", "<leader>fo", "<cmd>Telescope lsp_outgoing_calls<cr>", bufopts, "Find outgoing calls from outside (LSP)")
remap("n", "<leader>fx", "<cmd>Telescope diagnostics bufnr=0<cr>", bufopts, "Find errors (LSP)")

remap("n", "th", "<cmd>:tabfirst<cr>", bufopts, "First tab")
remap("n", "tk", "<cmd>:tabnext<cr>", bufopts, "Next tab")
remap("n", "tj", "<cmd>:tabprev<cr>", bufopts, "Previous tab")
remap("n", "tl", "<cmd>:tablast<cr>", bufopts, "Last tab")
remap("n", "tt", "<cmd>:tabedit<cr>", bufopts, "New tab")
remap("n", "td", "<cmd>:tabclose<cr>", bufopts, "Close tab")
remap("n", "tn", "<cmd>:tabmove -1<cr>", bufopts, "Move tab next")
remap("n", "tm", "<cmd>:tabmove +1<cr>", bufopts, "Move tab previous")

-- window management
remap("n", "<C-S-Right>", "<cmd>:vertical resize -1<cr>", bufopts, "Minimize window")
remap("n", "<C-S-Left>", "<cmd>:vertical resize +1<cr>", bufopts, "Maximize window")

-- formatting
remap("n", "Q", "gqap", bufopts, "Format paragraph")
remap("x", "Q", "gq", bufopts, "Format paragraph")
remap("n", "<leader>Q", "vapJgqap", bufopts, "Merge paragraphs")

--
-- Plugins
--

-- vim-marked
remap("n", "<leader>mo", "<cmd>MarkedOpen<cr>", bufopts, "Open marked")

-- vim-pencil
remap("n", "<leader>qc", "<Plug>ReplaceWithCurly", bufopts, "Curl quotes")
remap("n", "<leader>qs", "<Plug>ReplaceWithStraight", bufopts, "Straighten quotes")

-- trouble
remap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", bufopts, "Display errors")
remap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", bufopts, "Display workspace errors")
remap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", bufopts, "Display document errors")

-- symbols-outline
remap("n", "<leader>o", "<cmd>SymbolsOutline<cr>", bufopts, "Show symbols")

-- oil
remap("n", "<leader>n", "<cmd>Oil<cr>", bufopts, "Oil")

-- vim-test
remap("n", "<leader>vt", "<cmd>TestNearest<cr>", bufopts, "Test nearest")
remap("n", "<leader>vf", "<cmd>TestFile<cr>", bufopts, "Test file")
remap("n", "<leader>vs", "<cmd>TestSuite<cr>", bufopts, "Test suite")
remap("n", "<leader>vl", "<cmd>TestLast<cr>", bufopts, "Test last")
remap("n", "<leader>vg", "<cmd>TestVisit<cr>", bufopts, "Go to test")

-- nvim-dap
remap("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", bufopts, "Set breakpoint")
remap("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", bufopts,
  "Set conditional breakpoint")
remap("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
  bufopts, "Set log point")
remap("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>", bufopts, "Clear breakpoints")
remap("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>", bufopts, "List breakpoints")

remap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", bufopts, "Continue")
remap("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", bufopts, "Step over")
remap("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", bufopts, "Step into")
remap("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", bufopts, "Step out")
remap("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", bufopts, "Disconnect")
remap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", bufopts, "Terminate")
remap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", bufopts, "Open REPL")
remap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", bufopts, "Run last")
remap("n", "<leader>di", function() require "dap.ui.widgets".hover() end, bufopts, "Variables")
remap("n", "<leader>d?", function()
  local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
end, bufopts, "Scopes")
remap("n", "<leader>df", "<cmd>Telescope dap frames<cr>", bufopts, "List frames")
remap("n", "<leader>dh", "<cmd>Telescope dap commands<cr>", bufopts, "List commands")

remap("n","<leader>pl","<cmd>:TigGrep<cr>", bufopts,"tig grep multi use")