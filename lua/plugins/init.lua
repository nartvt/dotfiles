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
	-- 'ludovicchabant/vim-gutentags',
  'ixru/nvim-markdown',
	'leafOfTree/vim-svelte-plugin',
  'wbthomason/packer.nvim',

-- 'mfussenegger/nvim-jdtls',
	'nvim-lua/plenary.nvim',
	'tpope/vim-commentary',
	'tpope/vim-fugitive',
	'tpope/vim-repeat',
	'tpope/vim-rhubarb',
	'tpope/vim-surround',
	'tpope/vim-unimpaired',
--	'tyru/open-browser.vim',
	'andymass/vim-matchup',
	'fatih/vim-go',
	'kdheepak/lazygit.nvim',
	'junegunn/fzf',
	'junegunn/fzf.vim',
	'voldikss/vim-floaterm',
	'vim-airline/vim-airline-themes',
	'airblade/vim-gitgutter',
	'tveskag/nvim-blame-line',
	'iberianpig/tig-explorer.vim',
	'rbgrouleff/bclose.vim',
	'scrooloose/nerdTree',
	'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'natebosch/vim-lsc',
  'jiangmiao/auto-pairs',
  -- 'skanehira/docker-compose.vim',
  'ellisonleao/gruvbox.nvim',
  'github/copilot.vim',
  ' monsonjeremy/onedark.nvim',
	{
		'folke/trouble.nvim',
		config = function()
			require("trouble").setup({
				mode = "document_diagnostics"
			})
		end
	},
  {
  "mfussenegger/nvim-dap",
  config = function() end,
  },
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
		'hrsh7th/nvim-cmp',
    dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
			'onsails/lspkind.nvim',
		},
		config = function() require('config/nvim-cmp') end,
	},
-- 	{
-- 		'mfussenegger/nvim-dap',
-- 		config = function() require('config/nvim-dap') end,
-- 	},
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup {
				options = { theme = 'gruvbox' },
			}
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-telescope/telescope-dap.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			'nvim-telescope/telescope-ui-select.nvim',
		},
		config = function() require('config/telescope') end,
	},
	{
		'nvim-tree/nvim-web-devicons'
	},
	{
  'nvim-treesitter/nvim-treesitter',
	    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	    config = function() require('config/nvim-treesitter') end,
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
