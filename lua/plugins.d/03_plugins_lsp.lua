plugins.lsp = {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = {
            ensure_installed = {
                "bashls",
                "clangd",
                "dockerls",
                "gopls",
                "jedi_language_server",
                "jsonls",
                "jsonnet_ls",
                "lemminx",
                "marksman",
                "sumneko_lua",
                "taplo",
                "tsserver",
            },
        }
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = {
            ensure_installed = {
                "bash-language-server",
                "codespell",
                "gofumpt",
                "goimports",
                "jq",
                "prettier",
                "shellcheck",
                "shfmt",
            },
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = { "jose-elias-alvarez/null-ls.nvim" },
        config = function()
            require("mason-null-ls").setup {
                ensure_installed = {
                    "clang_format",
                    "codespell",
                    "gofumpt",
                    "goimports",
                    "golangci_lint",
                    "jq",
                    "prettier",
                    "sh",
                    "shellcheck",
                    "shfmt",
                },
                automatic_installation = false,
                automatic_setup = true, -- Recommended, but optional
            }
            require("null-ls").setup()
            require("mason-null-ls").setup_handlers({})
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }
        end
    },
    {
        'ray-x/lsp_signature.nvim',
        config = function()
            require "lsp_signature".setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                hint_enable = false,
                handler_opts = {
                    border = "rounded"
                    -- border = "single"
                },
            })

            require 'lsp_signature'.on_attach()
        end
    },
}
