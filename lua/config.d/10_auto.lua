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
            vim.keymap.set({ "n", "v" }, "<leader>sd", vim.lsp.buf.hover, { buffer = args.buf })
            vim.keymap.set({ "n", "v" }, "<leader>gd", vim.lsp.buf.type_definition)
        end
    end,
})
