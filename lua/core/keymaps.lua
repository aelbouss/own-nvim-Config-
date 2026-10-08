local keymap = vim.keymap

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-s>", "<cmd>w<CR>")
keymap.set("v", ">", ">gv")
keymap.set("v", "<", "<gv")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<leader>t", "<cmd>belowright split | terminal<CR><cmd>resize 10<CR>") -- open terminal --
keymap.set("t", "<Esc>", [[<C-\><C-n>]]) -- turn normal mode in terminal --
