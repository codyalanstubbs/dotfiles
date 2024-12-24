return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "gopls",
                "goimports",
                "gofumpt",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                gopls = {},
            },
        },
    },

}
