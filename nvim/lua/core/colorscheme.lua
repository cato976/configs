local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
    print("Color scheme not found!")
    return
end

local opt = vim.opt -- for conciseness

opt.background = "dark"

vim.g["gruvbox_contrast_dark "] = "hard"

vim.g["gruvbox_invert_selection"] = "0"
