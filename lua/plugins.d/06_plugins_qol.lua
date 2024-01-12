plugins.qol = {
    {

        "famiu/bufdelete.nvim",
        config = function()
            -- bufdelete mapping - currently focused buffer
            vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>", { silent = true })
        end,
    },
    {
        "distek/panel.nvim",
        config = function()
            require("panel").setup({
                size = 15,
                views = {
                    {
                        -- the name of the panel view (will also be shown in the winbar)
                        name = "Terminal",
                        -- the filetype to lock to the panel
                        ft = "toggleterm",
                        -- The open function should return the buffer ID of whatever we want in the panel
                        open = function()
                            -- open a new terminal in a split (we *want* to create a new window)
                            vim.cmd("split +term")
                            -- Grab the buffer's ID
                            local bufid = vim.api.nvim_get_current_buf()
                            -- hide the window (closing could delete the buffer, we don't want that)
                            vim.api.nvim_win_hide(vim.api.nvim_get_current_win())
                            -- Plugins would do this for you typically
                            vim.bo[bufid].filetype = "toggleterm"
                            -- finally return the new buffer ID
                            return bufid
                        end,

                        -- close is for a specific scenario in which the filetype relies on a specific window
                        -- Trouble is a good example of this
                        close = nil,
                        -- Additional window options to apply to the panel when this buffer is focused
                        wo = {
                            winhighlight = "Normal:ToggleTermNormal",
                            number = true,
                            relativenumber = true,
                            wrap = false,
                            list = false,
                            signcolumn = "no",
                            statuscolumn = "",
                        },
                    },
                }
            })

            vim.keymap.set("n", "<leader>pt", ":lua require('panel').toggle()<cr>")
            vim.keymap.set("n", "<leader>pn", ":lua require('panel').next()<cr>")
            vim.keymap.set("n", "<leader>pp", ":lua require('panel').previous()<cr>")
        end
    },
    {
        "nvim-lua/plenary.nvim",
    },
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
            vim.keymap.set({ 'n', 'x' },
                '<leader>cmt',
                '<cmd>set operatorfunc=v:lua.__flip_flop_comment<cr>g@',
                {
                    silent = true,
                    desc = "toggle the comment state of each line individually"
                }
            )
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", ":Git | lua Util.Float()<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gw", ":Gwrite<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gc", ":Git commit | lua Util.Float()<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gsh", ":Git push<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gll", ":Git pull<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gvd", ":Gvdiff<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gr", ":GRemove<cr>", { silent = true })
            vim.keymap.set("n", "<leader>o", ":GBrowse<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gj", ":diffget //3<cr>", { silent = true })
            vim.keymap.set("n", "<leader>gf", ":diffget //2<cr>", { silent = true })
        end
    },
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
        -- Better incsearch
        'kevinhwang91/nvim-hlslens',
        config = function()
            require("hlslens").setup()
            vim.keymap.set("n", "n",
                "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
            vim.keymap.set("n", "N",
                "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")
        end,
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
        main = "ibl",
        opts = {},
        config = {},
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
        config = function()
            require("refactoring").setup({
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
            })

            vim.keymap.set("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
            vim.keymap.set("v", "<leader>rf",
                [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
            vim.keymap.set("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
            vim.keymap.set("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
            vim.keymap.set("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]])
            vim.keymap.set("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]])
            vim.keymap.set("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
        end
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

            vim.keymap.set("n", "<leader>pf", "<cmd>lua require('telescope.builtin').find_files()<cr>")
            vim.keymap.set("n", "<leader>pv", ":wincmd v <bar> lua require('telescope.builtin').find_files()<cr>")
            vim.keymap.set("n", "<leader>ph", ":wincmd s <bar> lua require('telescope.builtin').find_files()<cr>")
            vim.keymap.set("n", "<leader>pg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        config = function()
            require("nvim-tree").setup({
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
            })
            vim.keymap.set("n", "<leader>ft", "NvimTreeToggle")
        end
    }
}
