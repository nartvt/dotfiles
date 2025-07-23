return {
    {"williamboman/mason.nvim",
      build = function ()
        pcall(vim.cmd, "MasonUpdate")
      end
    },
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
}

