vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "<leader>ev", ":<C-U>tab drop $MYVIMRC<CR>")
keymap.set("n", "<leader>l", "<C-w>l")
keymap.set("n", "<leader>h", "<C-w>h")
keymap.set("n", "<leader>k", "<C-w>k")
keymap.set("n", "<leader>j", "<C-w>j")
keymap.set("n", "<leader>q", "<C-w>q") -- nnoremap <leader>q :call <SID>QuitWindow()<CR> 
keymap.set("n", "<C-f>", ":Rg") -- fuzy find

-- nvim-tree
keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

-- OmniSharp bindings
keymap.set("n", "<leader>rt", ":OmniSharpRunTests<CR>")
keymap.set("n", "<leader>rt", ":TestNearest<CR>")
keymap.set("n", "<leader>rf", ":OmniSharpRunTestFixture<CR>")
keymap.set("n", "<leader>ra", ":OmniSharpRunAllTest<CR>")
keymap.set("n", "<leader>rl", ":OmniSharpRunLastTest<CR>")
keymap.set("n", "<leader>b",  ":OmniSharpBuildAsync<CR>")
keymap.set("n", "<leader><Space>", ":OmniSharpGetCodeActions<CR>")
--nnoremap <leader>b :Neomake<cr>

-- fzf
keymap.set("n", "<leader>o", ":Files<CR>")