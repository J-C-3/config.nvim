-- Use q to close window for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "fugitive",
        "gitcommit",
        "netrw",
    },
    callback = function()
        vim.keymap.set("n", "q", ":close<cr>", { buffer = true, silent = true })
    end
})

-- Run lsp formatter on write
local autoFormatGroup = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre",
    {
        group = autoFormatGroup,
        callback = function()
            local filetype = vim.bo[0].filetype
            if not string.match("scratchpad", vim.api.nvim_buf_get_name(0)) then
                if filetype == "go" then
                    require('go.format').goimport()
                else
                    vim.lsp.buf.format()
                end
            end
        end
    })

-- Run comments post buffer write
local postWrite = vim.api.nvim_create_augroup("PostWrite", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost",
    {
        group = postWrite,
        callback = function()
            local job = require("plenary.job")
            local filetype = vim.bo[0].filetype
            if not string.match("scratchpad", vim.api.nvim_buf_get_name(0)) then
                if filetype == "go" or filetype == "templ" then
                    job:new({
                        command = "go",
                        args = { "mod", "tidy" },
                    }):start()
                end
            end
        end
    })

-- Show definition & goto definition autocmd
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.hoverProvider then
            vim.keymap.set({ "n", "v" }, "<leader>sd", vim.lsp.buf.hover, { buffer = args.buf })
            vim.keymap.set({ "n", "v" }, "<leader>gd", vim.lsp.buf.definition)
            vim.keymap.set({ "n", "v" }, "<leader>gtd", vim.lsp.buf.type_definition)
        end
    end,
})
-- Set toggleterm bindings
-- local terminalGroup = vim.api.nvim_create_augroup("terminalGroup", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--     group = terminalGroup,
--     pattern = {
--         "toggleterm",
--     },
--     callback = function()
--         vim.keymap.set({ "n", "t" }, "<M-CR>", TermNew, { buffer = true, silent = true, desc = "Create new terminal" })
--         vim.keymap.set({ "n", "t" }, "<c-q>", TF.DeleteCurrentTerm, { buffer = true, silent = true, desc = "Create new terminal" })
--         vim.keymap.set({ "n", "t" }, "<M-r>", TF.RenameTerm, { buffer = true, silent = true, desc = "Create new terminal" })
--         vim.keymap.set({ "n", "t" }, "<M-Tab>", TF.NextTerm, { buffer = true, silent = true, desc = "Next terminal" })
--         vim.keymap.set({ "n", "t" }, "<M-S-Tab>", TF.PrevTerm, { buffer = true, silent = true, desc = "Previous terminal" })
--     end
-- })

-- Arduino specific settings, probably better in ftplugin maybe?
local arduino = vim.api.nvim_create_augroup("arduino", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = arduino,
    pattern = {
        "arduino",
    },
    callback = function()
        vim.o.cindent = true
        vim.o.tabstop = 2
        vim.o.softtabstop = 2
        vim.o.shiftwidth = 2
        vim.o.expandtab = 2
    end
})
