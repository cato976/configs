local satatus, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
    print("Colorscheme not found!")
    return
end
