return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "goimports",
                "gofumpt",
                "intelephense",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {},
                intelephense = {
                    filetypes = { "php", "blade", "php_only" },
                    settings = {
                        intelephense = {
                            filetypes = { "php", "blade", "php_only" },
                            files = {
                                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                                maxSize = 5000000,
                            },
                        },
                    },
                },
            },
        },
    },

}
