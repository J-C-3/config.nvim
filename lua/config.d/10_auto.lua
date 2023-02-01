-- Use q to close window for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "help",
        "fugitive",
        "gitcommit",
    },
    -- command = "nnoremap <buffer> q :close<cr>"
    callback = function()
        vim.keymap.set("n", "q", ":close<cr>", { buffer = true, silent = true })
    end
})

-- Run lsp formatter on write
vim.api.nvim_create_autocmd("BufWritePre",
    {
        callback = function()
            vim.lsp.buf.format()
        end
    })
