vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>ev", ":<C-U>tab drop $MYVIMRC<CR>")
keymap.set("n", "<leader>l", "<C-w>l")
keymap.set("n", "<leader>h", "<C-w>h")
keymap.set("n", "<leader>k", "<C-w>k")
keymap.set("n", "<leader>j", "<C-w>j")
keymap.set("n", "<leader>q", "<C-w>q") -- nnoremap <leader>q :call <SID>QuitWindow()<CR> 
keymap.set("n", "<C-f>", ":Rg ") -- fuzy find
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move highligthed text down
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move highligthed text up
keymap.set("n", "<leader>bb", ":buffers<CR>")

-- nvim-tree
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

--nnoremap <leader>b :Neomake<cr>

-- fzf
keymap.set("n", "<leader>o", ":Files<CR>")
