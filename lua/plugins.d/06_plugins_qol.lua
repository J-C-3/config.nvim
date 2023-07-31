plugins.qol = {
    {
        "ethanholz/nvim-lastplace",
        lazy = false,
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
                lastplace_open_folds = true,
            })
        end
    },
    { "ray-x/guihua.lua" },
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup({
                ---LHS of toggle mappings in NORMAL mode
                toggler = {
                    ---Line-comment toggle keymap
                    line = '<leader>cmm',
                    ---Block-comment toggle keymap
                    block = '<leader>cbb',
                },
                ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                opleader = {
                    ---Line-comment keymap
                    line = '<leader>cm',
                    ---Block-comment keymap
                    block = '<leader>cb',
                },
                ---LHS of extra mappings
                extra = {
                    ---Add comment on the line above
                    above = '<leader>cO',
                    ---Add comment on the line below
                    below = '<leader>co',
                    ---Add comment at the end of line
                    eol = '<leader>cA',
                },

            })
            local ft = require('Comment.ft')
            ft.set('arduino', ft.get('cpp'))
        end,
    },
    { "tpope/vim-fugitive" },
    {
        "simrat39/symbols-outline.nvim",
        config = true
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("telescope").load_extension("git_worktree")
        end
    },
    {
        'kevinhwang91/nvim-hlslens',
        config = true,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = true,
    },
    {
        'folke/which-key.nvim',
        config = {
            triggers_blacklist = {
                c = { "h" },
            }
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        },
    },
    {
        "windwp/nvim-autopairs",
        config = {
            disable_filetype = { "TelescopePrompt", "vim" },
            disable_in_macro = true,
            ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
            enable_moveright = true,
            enable_afterquote = true,         -- add bracket pairs after quote,
            enable_check_bracket_line = true, --- check bracket in same line,
            map_bs = true,                    -- map the <BS> key,
            map_c_w = false,                  -- map <c-w> to delete an pair if possible,
            check_ts = true,
            ts_config = {
                lua = { "string" }, -- it will not add a pair on that treesitter node
                javascript = { "template_string" },
                java = false,       -- don't check treesitter on java
            },
            function()
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
            end,
        },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter"
        },
        config = {
            -- prompt for return type
            prompt_func_return_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
            -- prompt for function parameters
            prompt_func_param_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
        },
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = "mfussenegger/nvim-dap",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        n = {
                            ["<esc>"] = require("telescope.actions").close,
                        },
                    },
                },
            })
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("dap")
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = {
            sort_by = "case_sensitive",
            sync_root_with_cwd = true,
            view = {
                width = {
                    min = 30,
                    max = 30
                }
                -- mappings = {
                --   list = {
                --     { key = "u", action = "dir_up" },
                --   },
                -- },
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
            tab = {
                sync = {
                    open = false,
                    close = false,
                    ignore = {},
                },
            },
            update_focused_file = {
                update_root = true
            }
        },
    }
}
