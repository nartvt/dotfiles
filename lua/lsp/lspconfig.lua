-- LSP Configuration
local vim = vim
local util = require("me.util")
-- local remap = util.remap

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = require("lsp.common").on_attach
-- local server_name = "tsserver"
local bin_name = "typescript-language-server"

-- add completion capability
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
lspconfig['dartls'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

require('java').setup()
require('lspconfig').jdtls.setup({
  on_attach = on_attach,
  root_markers = {
  'settings.gradle',
  'settings.gradle.kts',
  'pom.xml',
  'build.gradle',
  'mvnw',
  'gradlew',
  'build.gradle',
  'build.gradle.kts',
  '.git',
 },

 -- load java test plugins
 java_test = {
  enable = true,
 },

 -- load java debugger plugins
 java_debug_adapter = {
  enable = true,
 },

 jdk = {
  -- install jdk using mason.nvim
  auto_install = true,
 },

 notifications = {
  -- enable 'Configuring DAP' & 'DAP configured' messages on start up
  dap = true,
 },
})

lspconfig['ltex'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "bib", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" },
	settings = {
		ltex = {
			language = "en-CA",
		}
	}
}

lspconfig['gopls'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	}
}

lspconfig['pyright'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		pyright = {
			analysis = {
				useLibraryCodeForTypes = true,
			},
		},
	}
}

lspconfig['solargraph'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig['svelte'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig['tsserver'].setup {
	on_attach = on_attach,
  default_config = util.utf8_config {
    cmd = {bin_name, "--stdio"};
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"};
    root_dir = util.root_pattern("package.json");
  },
	capabilities = capabilities,
}

lspconfig['erlangls'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

lspconfig['lua_ls'].setup{
  	on_attach = on_attach,
    capabilities = capabilities,
}
