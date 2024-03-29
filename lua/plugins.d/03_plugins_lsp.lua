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
                "arduino_language_server",
                "bufls",
                "bashls",
                "clangd",
                "dockerls",
                "gopls",
                "jedi_language_server",
                "jsonls",
                "jsonnet_ls",
                "lemminx",
                "marksman",
                "lua_ls",
                "taplo",
                "templ",
                "tsserver",
                "zls",
            },
        },
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
        dependencies = { "nvimtools/none-ls.nvim" },
        config = function()
            require("mason-null-ls").setup {
                ensure_installed = {
                    "clang_format",
                    "codespell",
                    "golangci_lint",
                    "jq",
                    "prettier",
                    "shellcheck",
                    "shfmt",
                },
                automatic_installation = true,
                automatic_setup = true, -- Recommended, but optional
                handlers = {}
            }
            local null_ls = require("null-ls")
            null_ls.setup()
            -- Disable codespell autoformat
            null_ls.deregister(null_ls.builtins.formatting.codespell)
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    local lspconfig = require("lspconfig")
                    if server_name == "clangd" then
                        lspconfig["clangd"].setup({
                            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
                        })
                    else
                        lspconfig[server_name].setup({})
                    end
                end,
            })
            if vim.fn.executable("htmx-lsp") then
                require("lspconfig").htmx.setup({
                    filetypes = { "templ", "html", "htmx", "js", "go" }
                })
            end

            vim.keymap.set("n", "<leader>Li", "<cmd>LspInfo<CR>")
            vim.keymap.set("n", "<leader>Lr", "<cmd>LspRestart<CR>")
            vim.keymap.set("n", "<leader>Ls", "<cmd>LspStart<CR>")
            vim.keymap.set("n", "<leader>LS", "<cmd>LspStop<CR>")
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
