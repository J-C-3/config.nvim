plugins.dap = {
    {
        'rcarriga/nvim-dap-ui'
    },
    {
        'theHamsta/nvim-dap-virtual-text'
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "blue" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "red" })
            vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "green" })

            -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
            require("dapui").setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    -- use(a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                },
                layouts = {
                    {
                        elements = {
                            "scopes",
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
                controls = {
                    -- Requires Neovim nightly (or 0.8 when released)
                    enabled = true,
                    -- Display controls in this element
                    element = "console",
                    icons = {
                        pause = "",
                        play = "",
                        step_into = "",
                        step_over = "",
                        step_out = "",
                        step_back = "",
                        run_last = "",
                        terminate = "",
                    },
                },
                floating = {
                    max_height = 1,    -- These can be integers or a float between 0 and 1.
                    max_width = 19,    -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
            })

            require("nvim-dap-virtual-text").setup({})
        end
    },
    {
        "leoluz/nvim-dap-go",
        ft = { "go" },
        config = function()
            require("dap-go").setup({
                -- Additional dap configurations can be added.
                -- dap_configurations accepts a list of tables where each entry
                -- represents a dap configuration. For more details do:
                -- :help dap-configuration
                dap_configurations = {
                    {
                        -- Must be "go" or it will be ignored by the plugin
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                -- delve configurations
                delve = {
                    -- the path to the executable dlv which will be used for debugging.
                    -- by default, this is the "dlv" executable on your PATH.
                    path = "dlv",
                    -- time to wait for delve to initialize the debug session.
                    -- default to 20 seconds
                    initialize_timeout_sec = 20,
                    -- a string that defines the port to start delve debugger.
                    -- default to string "${port}" which instructs nvim-dap
                    -- to start the process in a random available port
                    port = "${port}",
                    -- additional args to pass to dlv
                    args = {},
                    -- the build flags that are passed to delve.
                    -- defaults to empty string, but can be used to provide flags
                    -- such as "-tags=unit" to make sure the test suite is
                    -- compiled during debugging, for example.
                    -- passing build flags using args is ineffective, as those are
                    -- ignored by delve in dap mode.
                    build_flags = "",
                },
            })
        end
    },
}
