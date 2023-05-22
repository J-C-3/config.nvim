local map = vim.keymap.set
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
local autoFormatGroup = vim.api.nvim_create_augroup("autoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre",
    {
        group = autoFormatGroup,
        callback = function()
            if not string.match("scratchpad", vim.api.nvim_buf_get_name(0)) then
                vim.lsp.buf.format()
            end
        end
    })

-- Show definition & goto definition autocmd
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.hoverProvider then
            map({ "n", "v" }, "<leader>sd", vim.lsp.buf.hover, { buffer = args.buf })
            map({ "n", "v" }, "<leader>gd", vim.lsp.buf.definition)
            map({ "n", "v" }, "<leader>gtd", vim.lsp.buf.type_definition)
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
--         map({ "n", "t" }, "<M-CR>", TermNew, { buffer = true, silent = true, desc = "Create new terminal" })
--         map({ "n", "t" }, "<c-q>", TF.DeleteCurrentTerm, { buffer = true, silent = true, desc = "Create new terminal" })
--         map({ "n", "t" }, "<M-r>", TF.RenameTerm, { buffer = true, silent = true, desc = "Create new terminal" })
--         map({ "n", "t" }, "<M-Tab>", TF.NextTerm, { buffer = true, silent = true, desc = "Next terminal" })
--         map({ "n", "t" }, "<M-S-Tab>", TF.PrevTerm, { buffer = true, silent = true, desc = "Previous terminal" })
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
