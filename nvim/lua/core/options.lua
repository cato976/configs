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


-- Basics  ----------------------------------------------------------------------{{{
-- vimrc folds
--vim.cmd([[
--    autocmd FileType vim setlocal fdc = 1
--    autocmd FileType vim setlocal foldmethod = marker
--    autocmd FileType vim setlocal foldlevel = 0
--]])
-- }}}
