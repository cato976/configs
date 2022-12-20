local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 8
opt.shiftwidth = 4
opt.expandtab = true

-- search settings
opt.incsearch = true

-- cursor line
opt.cursorline = true

opt.hlsearch = true

-- appearance
opt.colorcolumn = "80"
opt.background = "dark"

opt.spelllang = "en_us"

opt.guifont = {'CaskaydiaCove Nerd Font'}

vim.g["python3_host_prog"] = os.getenv("HOME") .. "/AppData/Local/Programs/Python/Python311/python.exe"

-- folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
--set nofoldenable                     " Disable folding at startup.

-- save undo info
if (not (vim.fn.isdirectory(vim.fn.expand("~") .. '/AppData/Local/nvim'))) then
    vim.fn.mkdir(vim.fn.expand("~") .. '/AppData/Local/nvim', 'p', 0770)
end
if (vim.fn.isdirectory(vim.fn.expand("~") .. '/AppData/Local/nvim/undo-dir')) then
    vim.fn.mkdir(vim.fn.expand("~") .. "/AppData/Local/nvim/undo-dir", 'p', 0700)
end
opt.undodir = vim.fn.expand("~") .. "/AppData/Local/nvim/undo-dir"
opt.undofile = true

-- Basics  ----------------------------------------------------------------------{{{
-- vimrc folds
--vim.cmd([[
--    autocmd FileType vim setlocal fdc = 1
--    autocmd FileType vim setlocal foldmethod = marker
--    autocmd FileType vim setlocal foldlevel = 0
--]])
-- }}}
