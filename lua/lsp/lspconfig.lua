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
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lspconfig = require("lspconfig")
lspconfig["dartls"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- Removed the problematic require("java").setup() call

require("supermaven-nvim").setup({
    keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
    },
    ignore_filetypes = { cpp = true }, -- or { "cpp", }
    color = {
        suggestion_color = "#ffffff",
        cterm = 244,
    },
    log_level = "info",                -- set to "off" to disable logging completely
    disable_inline_completion = false, -- disables inline completion for use with cmp
    disable_keymaps = false,           -- disables built in keymaps for more manual control
    condition = function()
        return false
    end -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
})

-- Configure JDTLS manually instead of using nvim-java
local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"

-- Don't setup JDTLS here - it should be handled by ftplugin/java.lua
-- lspconfig["jdtls"].setup({
--   This is now handled in ftplugin/java.lua
-- })

lspconfig["ltex"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "bib", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" },
    settings = {
        ltex = {
            language = "en-CA"
        }
    }
}

lspconfig["gopls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true
            },
            staticcheck = true
        }
    }
}

lspconfig["pyright"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pyright = {
            analysis = {
                useLibraryCodeForTypes = true
            }
        }
    }
}

lspconfig["solargraph"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig["svelte"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

-- lspconfig["tsserver"].setup {
lspconfig["ts_ls"].setup {
    on_attach = on_attach,
    default_config = util.utf8_config {
        cmd = { bin_name, "--stdio" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx"
        },
        root_dir = util.root_pattern("package.json")
    },
    capabilities = capabilities
}

lspconfig["erlangls"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig["lua_ls"].setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig["metals"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "metals"
    },
    filetypes = {
        "scala"
    },
    init_options = {
        compilerOptions = {
            snippetAutoIndent = false
        },
        isHttpEnabled = true,
        statusBarProvider = "show-message"
    }
}
