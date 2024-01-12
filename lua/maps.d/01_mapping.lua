if vim.loop.os_uname().sysname == "Darwin" then
    vim.keymap.set("n", "gx", 'yiW:!open <C-R>"<CR><Esc>')
elseif vim.loop.os_uname().sysname == "Linux" then
    vim.keymap.set("n", "gx", 'yiW:!xdg-open <C-R>"<CR><Esc>')
end
-- Fuck `q:` && `F1`
-- https://www.reddit.com/r/neovim/comments/lizyxj/how_to_get_rid_of_q/
-- won't work if you take too long to do perform the action, but that's fine
vim.keymap.set("n", "q:", "<nop>", { noremap = true })
vim.keymap.set("n", "<F1>", "<nop>", { noremap = true })


--Wordwrap
-- Allows for navigating through wrapped lines without skipping over wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keep selection with visual indentation
vim.keymap.set('v', ">", "'>gv'", { expr = true })
vim.keymap.set('v', "<", "'<gv'", { expr = true })

-- focus tabpages
vim.keymap.set("n", "<leader><Tab>", ":tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><S-Tab>", ":tabprevious<cr>", { desc = "Previous Tab" })

-- focus buffers
vim.keymap.set("n", "<Tab>", function()
    Util.skipUnwantedBuffers("next")
end)
vim.keymap.set("n", "<S-Tab>", function()
    Util.skipUnwantedBuffers("prev")
end)


-- Window/buffer stuff
vim.keymap.set("n", "<leader>ss", "<cmd>split<cr>", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split Vertical" })

-- Split Terminal
vim.keymap.set("n", "<leader>stv", "<cmd>topleft vsplit term://" .. vim.o.shell .. "<CR>", { desc = "Vertical Term" })
vim.keymap.set("n", "<leader>sts", "<cmd>botright 15split term://" .. vim.o.shell .. "<CR>", { desc = "Horizontal Term" })

-- Term is set in terminal.lua
vim.keymap.set("t", "<C-p>", "<c-\\><c-n>")

-- Window navigation
-- Navigate between panes easily
vim.keymap.set("n", "<leader>h", ":wincmd h<cr>", { silent = true })
vim.keymap.set("n", "<leader>j", ":wincmd j<cr>", { silent = true })
vim.keymap.set("n", "<leader>k", ":wincmd k<cr>", { silent = true })
vim.keymap.set("n", "<leader>l", ":wincmd l<cr>", { silent = true })

-- Float
vim.keymap.set("n", "<leader>fw", "<cmd> lua Util.Float()<cr>")
-- vim.keymap.set("n", "<leader>fw", "<cmd> lua fn.Float(vim.defaulttable())<cr>")
