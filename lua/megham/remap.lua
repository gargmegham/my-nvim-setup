-- Set leader key to space
vim.g.mapleader = " "

-- Move selected lines up and down in visual mode while maintaining indentation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move selection up

-- Join lines without moving cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll down/up while keeping cursor in center
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Scroll down
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Scroll up

-- Keep search terms in the middle when navigating with n/N
vim.keymap.set("n", "n", "nzzzv") -- Jump to next search result and center
vim.keymap.set("n", "N", "Nzzzv") -- Jump to previous search result and center

-- Re-indent current paragraph and restore cursor position
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Paste without overwriting clipboard in visual mode
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard with <leader>y in normal and visual modes
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- Copy selection
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- Copy entire line

-- Delete without affecting clipboard in normal and visual modes
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- Format code using LSP with <leader>f
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quick navigation in quickfix list (Ctrl+k and Ctrl+j)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz") -- Next quickfix item
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz") -- Previous quickfix item

-- Quick navigation in location list (<leader>k and <leader>j)
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz") -- Next location list item
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") -- Previous location list item

-- Quick find-and-replace the word under cursor with <leader>s
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable with <leader>x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
