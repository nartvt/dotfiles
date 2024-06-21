local vim = vim
return {
  'spywhere/detect-language.nvim', -- Whose ls is it anyway?
	'aklt/plantuml-syntax',
  'tyru/open-browser.vim',
  'weirongxu/plantuml-previewer.vim',
	'bronson/vim-visual-star-search',
	{
		'chentoast/marks.nvim',
		config = function()
			require("marks").setup()
		end
	},
	'simrat39/symbols-outline.nvim',
	'godlygeek/tabular',
	'itspriddle/vim-marked',
  'ixru/nvim-markdown',
	'leafOfTree/vim-svelte-plugin',
  'wbthomason/packer.nvim',

	'nvim-lua/plenary.nvim',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-rhubarb',
	'tpope/vim-surround',
	'tpope/vim-unimpaired',
	'andymass/vim-matchup',
	'rbgrouleff/bclose.vim',
	'jiangmiao/auto-pairs',
  "Exafunction/codeium.nvim",
--  'github/copilot.vim',
  -- 'skanehira/docker-compose.vim',
  'neoclide/coc-solargraph',
   'vim-ruby/vim-ruby',
   	{
		'folke/trouble.nvim',
		config = function()
			require("trouble").setup({
				mode = "document_diagnostics"
			})
		end
	},
--   {
--   "mfussenegger/nvim-dap",
--   config = function() end,
--   },
	{
		'folke/which-key.nvim',
		config = function()
			require("which-key").setup()
		end
	},
	{
		'gelguy/wilder.nvim',
		config = function() require('config/wilder') end,
	},
	{
		'goolord/alpha-nvim',
		config = function()
			require('alpha').setup(require 'alpha.themes.startify'.config)
		end
	},
 	{
 		'mfussenegger/nvim-dap',
 		config = function() require('config/nvim-dap') end,
 	},
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup {
				options = { theme = 'gruvbox' },
			}
		end
	},
 {
		'simrat39/symbols-outline.nvim',
		config = function()
			require("symbols-outline").setup {
				auto_close = true,
			}
		end
	},
	{
		'stevearc/oil.nvim',
		config = function()
			require("oil").setup({
				skip_confirm_for_simple_edits = true,
			})
		end
	}
},{
  -- plugin for lua development
  "folke/neodev.nvim",
  opts = {}
}
