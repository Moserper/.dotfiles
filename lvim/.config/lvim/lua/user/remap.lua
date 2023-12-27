vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "*", "*zz")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n","L", ":wincmd l<CR>")
-- vim.keymap.set("n","H", ":wincmd h<CR>")
-- vim.keymap.set("n","K", ":wincmd k<CR>")
-- vim.keymap.set("n","J", ":wincmd j<CR>")
vim.keymap.set("n", "<leader>s", ":sp<CR>")
vim.keymap.set("n", "<leader>v", ":vsp<CR>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("v", "<leader>c", "<Plug>(comment_toggle_linewise_visual)")

-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
